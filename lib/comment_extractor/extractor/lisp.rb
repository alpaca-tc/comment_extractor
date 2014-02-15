class CommentExtractor::Extractor::Lisp < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.el$/
  filetype 'lisp'

  define_bracket '"'
  define_rule start: /;+/
end
