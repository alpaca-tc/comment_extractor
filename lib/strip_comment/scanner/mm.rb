class CommentParser::Scanner::Mm < CommentParser::Scanner
  filename /\.mm$/
  filetype 'mm'

  include CommentParser::Scanner::Concerns::SlashScanner
end
