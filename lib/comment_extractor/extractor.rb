require 'strscan'
require 'comment_extractor/code_object'
require 'comment_extractor/extractor/concerns/simple_extractor'
require 'comment_extractor/extractor/concerns/slash_extractor'

module CommentExtractor
  class Extractor
    REGEXP = {
      BREAK: /(?:\r?\n|\r)/,
    }.freeze

    attr_reader :content
    attr_accessor :comments

    def initialize(content)
      @content = content
      @comments = []
    end

    # #extract_comments should retrun Array contains instance of CodeObject::Comment
    def extract_comments
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
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
