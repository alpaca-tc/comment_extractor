class CommentParser::Scanner::Go < CommentParser::Scanner
  filename /\.go$/
  filetype 'go'

  include CommentParser::Scanner::Concerns::SlashScanner
end
