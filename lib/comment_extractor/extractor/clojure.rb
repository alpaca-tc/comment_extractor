require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Clojure < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.clj$/
  filetype 'clojure'

  define_default_bracket
  comment start_with: /;+/
end
