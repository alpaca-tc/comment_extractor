class CommentParser::Scanner::Class < CommentParser::Scanner
  filename /\.class$/
  filetype 'class'

  include CommentParser::Scanner::Concerns::SlashScanner
end
