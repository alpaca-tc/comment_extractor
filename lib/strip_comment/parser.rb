## Parser finds scanner klass from file_name
module StripComment::Parser
  class << self
    attr_accessor :scanners

    def for(file_object)
      if parser = can_parse(file_object)
        parser = const_get(parser) if parser.is_a?(Symbol) # :Klass => Klass
        parser.new(file_object.content, file_object)
      end
    end

    def can_parse(file_object)
      return if file_object.binary?
      parser = nil

      if file_object.shebang
        parser = can_parse_by_shebang(file_object.shebang)
      end

      unless parser
        parser = can_parse_by_filename(file_object.path)
      end

      parser
    end

    def register_scanner(klass_or_symbol, rule = {})
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
