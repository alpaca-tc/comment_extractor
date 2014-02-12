## Parser finds scanner klass from file_name
module CommentParser::Parser
  class << self
    attr_accessor :scanners

    # [todo] - Implements Parser.new method and it contains scanner
    def for(file)
      if parser = can_parse(file)
        parser = const_get(parser) if parser.is_a?(Symbol) # :Klass => Klass
        parser.new(file, file.content)
      end
    end

    def can_parse(file)
      return if file.binary?
      parser = nil

      if file.shebang
        parser = can_parse_by_shebang(file.shebang)
      end

      unless parser
        parser = can_parse_by_filename(file.path)
      end

      parser
    end

    def regist_scanner(klass_or_symbol, rule = nil)
      if rule.nil? && klass_or_symbol.respond_to?(:definition)
        rule = klass_or_symbol.definition
      end

      scanners[rule] = klass_or_symbol
    end

    def can_parse_by_shebang(shebang)
      find_scanner_by(:shebang, shebang)
    end

    def can_parse_by_filename(filename)
      find_scanner_by(:filename, filename)
    end

    private

    def find_scanner_by(key, value)
      return unless key || value

      scanners.each_key do |rule_of|
        if rule_of.has_key?(key) && rule_of[key] =~ value
          return scanners[rule_of]
        end
      end

      nil
    end

    def scanners
      @@scanners ||= {}
    end
  end
end

require 'comment_parser/scanner'
