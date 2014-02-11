class CommentParser::Scanner::JavaScript < CommentParser::Scanner
  filename /\.js$/
  filetype 'javascript'
  shebang /.*(js|node)$/

  include CommentParser::Scanner::Concerns::SlashScanner
end
