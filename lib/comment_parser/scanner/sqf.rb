class CommentParser::Scanner::Sqf < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SlashScanner

  filename /\.sqf$/
  filetype 'sqf'
end
