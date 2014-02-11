class CommentParser::Scanner::D < CommentParser::Scanner
  shebang /\/dmd/
  filename /\.d$/
  filetype 'd'

  include CommentParser::Scanner::Concerns::SlashScanner
end
