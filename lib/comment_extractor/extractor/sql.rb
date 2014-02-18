require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Sql < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.sql$/
  filetype 'sql'

  define_default_bracket
  comment start_with: '--'
  comment start_with: '/\*', end_with: '\*/', type: BLOCK_COMMENT
end
