require 'strscan'
require 'comment_parser/parser'

module CommentParser
  class Scanner
    attr_accessor :file_object, :content, :comments

    # [todo] - Separates common feature to other module and scanners includes them
    REGEXP = {
      BREAK: /(?:\r?\n|\r)/,
    }.freeze

    def initialize(file_object, content = nil)
      @file_object = file_object
      @content = content
      @comments = []
    end

    def scan
      raise 'Neet to implement'
    end

    def content
      @content ||= file_object.respond_to?(:content) ? file_object.content : ''
    end

    def build_scanner
      @scanner ||= StringScanner.new(self.content)
    end

    def current_line
      return unless instance_variable_defined?(:@scanner)

      corrective_line = 1
      corrective_line += 1 if self.file_object.shebang
      content[0...build_scanner.pos].count("\n") + corrective_line
    end

    def add_comment(line, comment, metadata = {})
      @comments << CommentParser::CodeObject::Comment.new.tap do |c|
        c.file = file_object
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

    def raise_report
      raise 'Error occurred. Please report to <https://github.com/alpaca-tc/comment_parser/issues>'
    end
  end

  scanner_path = File.expand_path('../scanner', __FILE__)
  module Scanner::Concerns; end
  # Requires common future for scanners
  Dir["#{scanner_path}/concerns/*.rb"].each { |f| require f }

  # Registers scanners in ./scanner/*.rb
  Dir["#{scanner_path}/*.rb"].each do |f|
    require f
    klass_name = f[%r![^/]+(?=\.rb$)!].split('_').collect(&:capitalize).join
    klass = Scanner.const_get(klass_name)
    Parser.regist_scanner(klass) unless klass.disabled?
  end
end
