class CommentParser::Scanner::Cpp < CommentParser::Scanner
  filename /\.cpp$/
  filetype 'cpp'

  include CommentParser::Scanner::Concerns::SlashScanner
end
