class CommentParser::Scanner::Cxx < CommentParser::Scanner
  filename /\.cxx$/
  filetype 'cxx'

  include CommentParser::Scanner::Concerns::SlashScanner
end
