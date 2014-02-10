class CommentParser::Scanner::Hpp < CommentParser::Scanner
  filename /\.hpp$/
  filetype 'hpp'

  include CommentParser::Scanner::Concerns::SlashScanner
end
