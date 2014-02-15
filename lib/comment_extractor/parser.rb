# [todo] - rename, re-architect
class CommentExtractor::Parser
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
      file = CommentExtractor::File.new(file) unless file.is_a?(CommentExtractor::File)
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

    def regist_scanner(klass, rule = nil)
      if rule.nil? && klass.respond_to?(:definition)
        rule = klass.definition
      end

      scanners[rule] = klass
    end

    def self.define_scanner_finder_by(*keys)
      keys.each do |key|
        define_method "find_scanner_by_#{key}" do |value|
          find_scanner_by(key, value)
        end
      end
    end
    define_scanner_finder_by :shebang, :filename, :filetype

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

require 'comment_extractor/scanner'
