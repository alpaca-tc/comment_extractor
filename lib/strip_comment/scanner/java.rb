class CommentParser::Scanner::Java < CommentParser::Scanner
  filename /\.java$/
  filetype 'java'

  include CommentParser::Scanner::Concerns::SlashScanner
end
