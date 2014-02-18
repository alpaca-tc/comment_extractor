require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Lisp < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.el$/
  filetype 'lisp'

  define_bracket '"'
  comment start_with: /;+/
end
