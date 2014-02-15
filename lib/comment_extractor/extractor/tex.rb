require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Tex < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.tex$/
  filetype 'tex'

  define_bracket '{'
  define_rule start: /(?<!\\)%/
  define_ignore_patterns /\\%/
end
