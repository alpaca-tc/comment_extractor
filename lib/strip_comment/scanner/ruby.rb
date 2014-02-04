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
        comments << token.value.strip
      end
    end
  end
end
