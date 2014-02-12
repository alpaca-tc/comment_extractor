class CommentParser::Scanner::Clojure < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.clj$/
  filetype 'clojure'

  define_default_bracket
  define_rule start: /;+/
end
