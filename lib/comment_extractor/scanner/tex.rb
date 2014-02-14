class CommentExtractor::Scanner::Tex < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.tex$/
  filetype 'tex'

  define_bracket '{'
  define_rule start: /(?<!\\)%/
  define_ignore_patterns /\\%/
end
