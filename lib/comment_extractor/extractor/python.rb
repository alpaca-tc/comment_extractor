require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Python < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.py$/
  filetype 'py'

  define_default_bracket
  comment start_with: '"""', end_with: '"""', type: BLOCK_COMMENT
  comment start_with: '"""', end_with: '"""', type: BLOCK_COMMENT
  comment start_with: '#'
end
