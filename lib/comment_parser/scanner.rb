require 'strscan'
require 'comment_parser/parser'

module CommentParser
  class Scanner
    module Concerns
    end

    attr_accessor :file, :content, :comments

    # [todo] - Separates common feature to other module and scanners includes them
    REGEXP = {
      BREAK: /(?:\r?\n|\r)/,
    }.freeze

    def initialize(file, content = nil)
      @file = file
      @content = content
      @comments = []
    end

    def scan
      raise 'Need to implement'
    end

    def content
      @content ||= file.respond_to?(:content) ? file.content : ''
    end

    def scanner
      @scanner ||= build_scanner
    end

    def current_line
      return unless instance_variable_defined?(:@scanner)

      corrective_line = 1
      corrective_line += 1 if self.file.shebang
      content[0...scanner.charpos].count("\n") + corrective_line
    end

    def add_comment(line, comment, metadata = {})
      @comments << CommentParser::CodeObject::Comment.new.tap do |c|
        c.file = file
        c.line = line
        c.value = comment
        c.metadata = metadata
      end
    end

    def self.disabled?
      @status == :disable
    end

    def self.disable!
      @status = :disable
    end

    def self.definition_attr(*keys)
      keys.each do |key|
        define_singleton_method key do |value|
          self.definition[key] = value
        end

        define_method key do
          self.class.definition[key]
        end
      end
    end

    definition_attr :shebang, :filetype, :filename

    def self.definition
      @definition ||= {}
    end

    private

    def build_scanner
      StringScanner.new(self.content)
    end

    def raise_report
      raise 'Error occurred. Please report to <https://github.com/alpaca-tc/comment_parser/issues>'
    end
  end
end

# Registers scanners in ./scanner/*.rb
scanner_path = File.expand_path('../scanner', __FILE__)
Dir["#{scanner_path}/concerns/*.rb"].each { |f| require f }
Dir["#{scanner_path}/*.rb"].each do |f|
  require f
  klass_name = f[%r![^/]+(?=\.rb$)!].split('_').collect(&:capitalize).join
  klass = CommentParser::Scanner.const_get(klass_name)
  CommentParser::Parser.regist_scanner(klass) unless klass.disabled?
end
