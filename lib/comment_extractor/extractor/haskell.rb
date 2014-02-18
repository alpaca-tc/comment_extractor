require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Haskell < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.hs$/
  filetype 'haskell'

  define_default_bracket
  comment start_with: '--'
  comment start_with: '{-', end_with: '-}', type: BLOCK_COMMENT
end
