require 'rdoc'

class StripComment::Scanner::Ruby < StripComment::Scanner
  filename /\.rb$/
  filetype 'ruby'
  shebang /.*ruby$/

  # [todo] - Uses original implementation for scanning comments
  class Options < Hash
    def tab_width
      2
    end
  end

  def scan
    tokens = RDoc::RubyLex.tokenize(content, Options.new)

    tokens.each_with_object([]) do |token, comments|
      if token.is_a?(RDoc::RubyToken::TkCOMMENT)
        comments << StripComment::CodeObject::Comment.new.tap do |c|
          c.file = @file_object
          c.line = token.line_no
          c.value = token.value
        end
      end
    end
  end
end
