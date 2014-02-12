class CommentParser::Scanner::Php < CommentParser::Scanner
  filename /\.php$/
  filetype 'php'

  include CommentParser::Scanner::Concerns::SlashScanner
end
