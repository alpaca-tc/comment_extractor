require 'rdoc'
require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Ruby < CommentExtractor::Extractor
  include CommentExtractor::CodeObject::Comment::Type

  filename /(?:Rakefile|Gemfile|\.rb|\.gemspec|Guardfile)$/
  filetype 'ruby'
  shebang /.*ruby$/

  class Options < Hash
    def tab_width
      2
    end
  end

  def scan
    tokens = RDoc::RubyLex.tokenize(content, Options.new)

    tokens.each do |token|
      case token
      when RDoc::RubyToken::TkRD_COMMENT # =begin ... =end
        token.value.split("\n").each_with_index do |comment, index|
          line_no = token.line_no + 1 + index
          add_comment(line_no, comment, type: BLOCK_COMMENT)
        end
      when RDoc::RubyToken::TkCOMMENT # # ...
        comment = token.value.sub(/^\s*#\s?/, '')
        add_comment(token.line_no, comment, type: ONE_LINER_COMMENT)
      end
    end
  end

  private

  def add_comment(line, comment, **metadata)
    comment_object = build_comment(line, comment, **metadata)
    code_objects << comment_object
  end
end
