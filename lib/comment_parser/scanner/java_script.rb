class CommentParser::Scanner::JavaScript < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner
  include CommentParser::Scanner::Concerns::SlashScanner

  filename /\.js$/
  filetype 'javascript'
  shebang /.*(js|node)$/

  define_regexp_bracket
end
