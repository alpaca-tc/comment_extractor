class CommentParser::Scanner::Cs < CommentParser::Scanner
  filename /\.cs$/
  filetype 'cs'

  include CommentParser::Scanner::Concerns::SlashScanner
end
