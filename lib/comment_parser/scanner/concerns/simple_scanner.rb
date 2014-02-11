module CommentParser::Scanner::Concerns::SimpleScanner
  def self.included(k)
    k.class_eval do |klass|
      extend ClassMethods
    end
  end

  module ClassMethods
    # rule = { single_line: { open: nil, close: nil }, multi_line: { open: nil, close: nil } }
    def define_rule(rule = {})
      @rule ||= Hash.new { |h,k| h[k] = Hash.new(&h.default_proc) }
      [:single_line, :multi_line].each do |key|
        @rule[key] = rule[key] if rule.has_key?(key)
      end
    end
    attr_reader :rule
  end

  def scan
    scanner = build_scanner

    until scanner.eos?
      case
      when scanner.scan(/"/)
        scanner.scan(/.*?(?<!\\)"/m)
      when scanner.scan(/'/)
        scanner.scan(/.*?(?<!\\)'/m)
      when scanner.scan(/#{rule[:multi_line][:open]}/)
        identify_multi_line_comment
      when scanner.scan(/#{rule[:single_line][:open]}/)
        identify_single_line_comment
      when scanner.scan(/(\w|\W)/), scanner.scan(CommentParser::Scanner::REGEXP[:BREAK])
        next
      end
    end
  end

  private

  def identify_single_line_comment
    scanner = build_scanner
    line_no = current_line
    comment = scanner.scan(/^.*$/)
    add_comment(line_no, comment)
  end

  def identify_multi_line_comment
    scanner = build_scanner
    line_no = current_line
    close_reg = rule[:multi_line][:close]
    comments = scanner.scan(/.*?#{close_reg}/m).sub(/#{close_reg}$/, '').split("\n")
    comments.each_with_index do |comment, index|
      add_comment(line_no + index, comment)
    end
  end

  def rule
    self.class.rule
  end
end
