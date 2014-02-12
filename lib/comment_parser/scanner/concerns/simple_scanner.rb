module CommentParser::Scanner::Concerns::SimpleScanner
  include CommentParser::CodeObject::Comment::Type

  def self.included(k)
    k.class_eval do |klass|
      extend ClassMethods
    end
  end

  module ClassMethods
    include CommentParser::CodeObject::Comment::Type

    def define_rule(open: nil, close: nil, type: ONE_LINER_COMMENT)
      @comment_regexp ||= []
      raise ArgumentError unless [type, open].all?

      definition = { open: build_regexp(open), type: type }

      if type == BLOCK_COMMENT
        definition[:close] = build_regexp(close, Regexp::MULTILINE)
      end
      @comment_regexp << definition
    end

    def define_bracket(char, options = 0)
      @brackets ||= []
      close_regexp = Regexp.new("(?<!\\\\)#{char}", options)
      @brackets << { open: Regexp.new(char), close: close_regexp }
    end

    def define_default_bracket
      self.define_bracket('"', Regexp::MULTILINE)
      self.define_bracket("'", Regexp::MULTILINE)
    end

    private

    def build_regexp(str_or_reg, type = 0)
      str_or_reg = str_or_reg.source if str_or_reg.respond_to?(:source)
      Regexp.new(str_or_reg, type)
    end
  end

  def scan
    until scanner.eos?
      case
      when scan_bracket
        next
      when scan_comment
        next
      when scanner.scan(CommentParser::Scanner::REGEXP[:BREAK])
        next
      when scanner.scan(/./)
        next
      else
        raise_report
      end
    end
  end

  def self.attr_definition(*keys)
    keys.each do |key|
      define_method key do
        self.class.instance_variable_get("@#{key}") || []
      end
    end
  end
  attr_definition :brackets, :comment_regexp

  private

  def scan_bracket
    brackets.each do |definition|
      open = definition[:open]
      close = definition[:close]
      next unless scanner.scan(open)
      return scanner.scan(Regexp.new(/.*?/.source + close.source, close.options))
    end

    nil
  end

  def scan_comment
    comment_regexp.each do |definition|
      next unless scanner.scan(definition[:open])
      case definition[:type]
      when ONE_LINER_COMMENT
        identify_single_line_comment
      when BLOCK_COMMENT
        identify_multi_line_comment(definition[:close])
      else
        raise_report
      end
    end

    nil
  end

  def identify_single_line_comment
    line_number = current_line
    comment = scanner.scan(/^.*$/)
    add_comment(line_number, comment, type: ONE_LINER_COMMENT)
  end

  def identify_multi_line_comment(regexp)
    line_no = current_line
    close_regexp = Regexp.new(/.*?/.source + regexp.source, regexp.options)
    comment_block = scanner.scan(close_regexp)

    remove_tail_regexp = Regexp.new(regexp.source + /$/.source)
    comments = comment_block.sub(remove_tail_regexp, '').split("\n")
    comments.each_with_index do |comment, index|
      add_comment(line_no + index, comment, type: BLOCK_COMMENT)
    end
  end

  def scanner
    @scanner ||= build_scanner
  end
end
