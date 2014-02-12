class CommentParser::Scanner::Tex < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.tex$/
  filetype 'tex'

  define_bracket '{'
  define_rule start: /(?<!\\)%/
  define_ignore_patterns /\\%/
end
