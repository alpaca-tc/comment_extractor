require 'rdoc'

class CommentParser::Scanner::Ruby < CommentParser::Scanner
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
    corrective_line = self.file_object.shebang ? 1 : 0

    tokens.each do |token|
      case token
      when RDoc::RubyToken::TkRD_COMMENT # =begin ... =end
        token.value.split("\n").each_with_index do |comment, index|
          line_no = token.line_no + corrective_line + 1 + index
          add_comment(line_no, comment)
        end
      when RDoc::RubyToken::TkCOMMENT # # ...
        line_no = token.line_no + corrective_line
        add_comment(line_no, token.value.sub(/^\s*#\s?/, ''))
      end
    end
  end

  private

  def line_is_comment_of_begin_keyword?(token)
    binding.pry
    File.readlines(self.file_object.path)[token.line_no] == /^=begin/
  end
end
