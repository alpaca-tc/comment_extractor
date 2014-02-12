class CommentParser::Scanner::Lisp < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.el$/
  filetype 'lisp'

  define_bracket '"'
  define_rule open: /;+/
end
