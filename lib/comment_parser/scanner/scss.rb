class CommentParser::Scanner::Scss < CommentParser::Scanner
  filename /\.scss$/
  filetype 'scss'

  include CommentParser::Scanner::Concerns::SlashScanner
end
