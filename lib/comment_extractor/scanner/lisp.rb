class CommentExtractor::Scanner::Lisp < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.el$/
  filetype 'lisp'

  define_bracket '"'
  define_rule start: /;+/
end
