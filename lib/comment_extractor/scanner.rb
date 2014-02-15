require 'strscan'
require 'comment_extractor/parser'

module CommentExtractor
  # [todo] - Scanner should not depend on File. so user give string argument to scanner.
  # [todo] - Scanner can use some Scanner to extract comment from file path
  class Scanner
    module Concerns; end

    # [todo] - Separate Regexp to other module
    REGEXP = {
      BREAK: /(?:\r?\n|\r)/,
    }.freeze

    attr_reader :content
    attr_accessor :comments

    def initialize(content)
      @content = content
      @comments = []
    end

    def scan
      raise 'Need to implement'
    end

    def current_line(scanner = nil)
      current_scanner = scanner || instance_variable_get(:@scanner)

      return unless current_scanner

      corrective_line = 1
      content[0...current_scanner.charpos].count("\n") + corrective_line
    end

    protected

    def scanner
      @scanner ||= build_scanner
    end

    # [review] - How should I implement this?
    # [todo] - Create Comments Class
    def add_comment(line, comment, metadata = {})
      @comments << CommentExtractor::CodeObject::Comment.new.tap do |c|
        c.line = line
        c.value = comment
        c.metadata = metadata
      end
    end

    def build_scanner
      StringScanner.new(@content)
    end

    private

    def raise_report
      raise 'Error occurred. Please report to <https://github.com/alpaca-tc/comment_extractor/issues>'
    end

    def self.disabled?
      @status == :disable
    end

    def self.disable!
      @status = :disable
    end

    def self.attr_definition_accessor(*keys)
      keys.each do |key|
        define_singleton_method key do |value|
          self.definition[key] = value
        end

        define_method key do
          self.class.definition[key]
        end
      end
    end
    attr_definition_accessor :shebang, :filetype, :filename

    def self.definition
      @definition ||= {}
    end
  end
end

# [todo] - Use require method
# Register scanners in ./scanner/*.rb
scanner_path = File.expand_path('../scanner', __FILE__)
Dir["#{scanner_path}/concerns/*.rb"].each { |f| require f }
Dir["#{scanner_path}/*.rb"].each do |f|
  require f
  klass_name = f[%r![^/]+(?=\.rb$)!].split('_').collect(&:capitalize).join
  klass = CommentExtractor::Scanner.const_get(klass_name)
  CommentExtractor::Parser.regist_scanner(klass) unless klass.disabled?
end
