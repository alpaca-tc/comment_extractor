class CommentParser::Scanner::H < CommentParser::Scanner
  filename /\.h$/
  filetype 'h'

  include CommentParser::Scanner::Concerns::SlashScanner
end
