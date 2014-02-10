class CommentParser::Scanner::Php < CommentParser::Scanner
  disable!
  filename /\.php$/
  filetype 'php'

  include CommentParser::Scanner::Concerns::SlashScanner
end
