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
      comment_object = StripComment::CodeObject::Comment.new
      comment_object.file = file_object
      comment_object.line = line
      comment_object.value = comment
      @comments << comment_object
    end

    class << self
      def shebang(value)
        definition[:shebang] = value
      end

      def filetype(value)
        definition[:filetype] = value
      end

      def filename(value)
        definition[:filename] = value
      end

      def definition
        @definition ||= {}
      end
    end
  end

  # def line_number(scanner)
  #   @text[0..@scanner.pos].count("\n") + 1
  # end

  # Registers scanners in ./scanner/*.rb
  scanner_path = File.expand_path('../scanner', __FILE__)
  Dir["#{scanner_path}/*.rb"].each do |f|
    require f
    klass_name = f[%r![^/]+(?=\.rb$)!].split('_').collect(&:capitalize).join
    Parser.regist_scanner(Scanner.const_get(klass_name))
  end
end
