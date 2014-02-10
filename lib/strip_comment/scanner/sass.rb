class CommentParser::Scanner::Sass < CommentParser::Scanner
  filename /\.sass$/
  filetype 'sass'

  include CommentParser::Scanner::Concerns::SlashScanner
end
