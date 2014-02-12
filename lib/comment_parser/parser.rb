## Parser finds scanner klass from file_name
class CommentParser::Parser
  def initialize(scanner)
    @scanner = scanner
  end

  def parse
    @scanner.scan
    @scanner.comments
  end

  class << self
    attr_accessor :scanners

    def for(file)
      file = CommentParser::File.new(file) unless file.is_a?(CommentParser::File)
      if scanner = can_parse(file)
        new(scanner.new(file))
      end
    end

    def can_parse(file)
      return if file.binary?
      scanner = nil

      if file.shebang
        scanner = find_scanner_by_shebang(file.shebang)
      end

      unless scanner
        scanner = find_scanner_by_filename(file.path)
      end

      scanner
    end

    def regist_scanner(klass_or_symbol, rule = nil)
      if rule.nil? && klass_or_symbol.respond_to?(:definition)
        rule = klass_or_symbol.definition
      end

      scanners[rule] = klass_or_symbol
    end

    def find_scanner_by_shebang(shebang)
      find_scanner_by(:shebang, shebang)
    end

    def find_scanner_by_filename(filename)
      find_scanner_by(:filename, filename)
    end

    def find_scanner_by_filetype(filetype)
      find_scanner_by(:filetype, filetype)
    end

    private

    def find_scanner_by(key, value)
      scanners.each_key do |rule_of|
        next unless rule_of.has_key?(key)

        rule = rule_of[key]
        comparison_operator = rule.is_a?(Regexp) ? :=~ : :==
        return scanners[rule_of] if rule.send(comparison_operator, value)
      end

      nil
    end

    def scanners
      @@scanners ||= {}
    end
  end
end

require 'comment_parser/scanner'
