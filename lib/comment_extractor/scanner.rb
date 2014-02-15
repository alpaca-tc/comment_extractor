require 'strscan'
require 'comment_extractor/parser'

module CommentExtractor
  # [todo] - Scanner should not depend on File. so user give string argument to scanner.
  # [todo] - Scanner can use some Scanner to extract comment from file path
  class Scanner
    module Concerns; end

    # [todo] - Remove file attribute and comments attribute
    attr_accessor :file, :content, :comments

    # [todo] - Separate Regexp to other module
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

    # [todo] - Remove Content
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

    # [review] - How should I implement this?
    def add_comment(line, comment, metadata = {})
      @comments << CommentExtractor::CodeObject::Comment.new.tap do |c|
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

    private

    # [todo] - Remove this
    def build_scanner
      StringScanner.new(self.content)
    end

    def raise_report
      raise 'Error occurred. Please report to <https://github.com/alpaca-tc/comment_extractor/issues>'
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
