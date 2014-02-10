class CommentParser::Scanner::C < CommentParser::Scanner
  filename /\.c$/
  filetype 'c'

  include CommentParser::Scanner::Concerns::SlashScanner
end
