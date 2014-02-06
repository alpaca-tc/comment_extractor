require 'strscan'
require 'strip_comment/parser'

module StripComment
  class Scanner
    attr_accessor :file_object, :content

    def initialize(file_object, content = nil)
      @file_object = file_object
      @content = content
    end

    def scan
      raise 'Neet to implement'
    end

    def content
      @content ||= file_object.respond_to?(:content) ? file_object.content : ''
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

  require 'strip_comment/scanner/ruby'
  Parser.register_scanner(Scanner::Ruby)
end
