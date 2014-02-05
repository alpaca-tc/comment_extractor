require 'rdoc'

class StripComment::Scanner::Ruby < StripComment::Scanner
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
        c = StripComment::CodeObject::Comment
        c.file = @file_object
        c.line = token.line_no
        c.value = token.value
        comments << c
      end
    end
  end
end
