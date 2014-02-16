require 'strscan'
require 'comment_extractor/code_object'
require 'comment_extractor/code_objects'
require 'comment_extractor/extractor/concerns/simple_extractor'
require 'comment_extractor/extractor/concerns/slash_extractor'

module CommentExtractor
  class Extractor
    REGEXP = {
      BREAK: /(?:\r?\n|\r)/,
    }.freeze
    SCHAME_ACCESSOR_NAMES = %i[shebang filetype filename]

    attr_reader :content, :code_objects

    def initialize(content, code_objects = nil)
      @content = content
      @code_objects = code_objects || CodeObjects.new
    end

    # #extract_comments should retrun CodeObjects contains instance
    # of CodeObject::Comment
    def extract_comments
      @extracted_comments ||= begin
        scan
        code_objects
      end
    end

    protected

    def scan
      raise NotImplementedError, "You must implement #{self.class}##{__method__}"
    end

    def scanner
      @scanner ||= build_scanner
    end

    def build_scanner
      StringScanner.new(@content)
    end

    def build_comment(line, comment, **metadata)
      metadata[:extractor] = self
      CodeObject::Comment.new(line: line, value: comment, **metadata)
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

    def self.schema_accessor(*keys)
      keys.each do |key|
        define_singleton_method key do |value = nil|
          if value
            self.schema[key] = value
          else
            self.schema[key]
          end
        end
      end
    end
    schema_accessor *SCHAME_ACCESSOR_NAMES

    def self.schema
      @schema ||= {}
    end
  end
end
