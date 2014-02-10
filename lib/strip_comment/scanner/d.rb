class CommentParser::Scanner::D < CommentParser::Scanner
  filename /\.d$/
  filetype 'd'

  include CommentParser::Scanner::Concerns::SlashScanner
end
