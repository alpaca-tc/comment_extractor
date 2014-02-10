class CommentParser::Scanner::Css < CommentParser::Scanner
  filename /\.css$/
  filetype 'css'

  include CommentParser::Scanner::Concerns::SlashScanner
end
