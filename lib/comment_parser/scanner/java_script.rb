class CommentExtractor::Scanner::JavaScript < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner
  include CommentExtractor::Scanner::Concerns::SlashScanner

  filename /\.js$/
  filetype 'javascript'
  shebang /.*(js|node)$/

  define_regexp_bracket
end
