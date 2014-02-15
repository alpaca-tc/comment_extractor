require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Haskell < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.hs$/
  filetype 'haskell'

  define_default_bracket
  define_rule start: '--'
  define_rule start: '{-', stop: '-}', type: BLOCK_COMMENT
end
