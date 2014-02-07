require 'strscan'
require 'strip_comment/parser'

module StripComment
  class Scanner
    attr_accessor :file_object, :content, :comments

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
      content[0..build_scanner.pos].count("\n") + 1
    end

    def add_comment(line, comment)
      @comments << StripComment::CodeObject::Comment.new.tap do |c|
        c.file = file_object
        c.line = line
        c.value = comment
      end
    end

    def self.definition_attr(*keys)
      keys.each do |key|
        define_singleton_method key do |value|
          self.definition[key] = value
        end
      end
    end

    definition_attr :shebang, :filetype, :filename

    def self.definition
      @definition ||= {}
    end
  end

  # Registers scanners in ./scanner/*.rb
  scanner_path = File.expand_path('../scanner', __FILE__)
  Dir["#{scanner_path}/*.rb"].each do |f|
    require f
    klass_name = f[%r![^/]+(?=\.rb$)!].split('_').collect(&:capitalize).join
    Parser.regist_scanner(Scanner.const_get(klass_name))
  end
end
