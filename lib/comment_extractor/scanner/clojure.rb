class CommentExtractor::Scanner::Clojure < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.clj$/
  filetype 'clojure'

  define_default_bracket
  define_rule start: /;+/
end
