require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Sql < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.sql$/
  filetype 'sql'

  define_default_bracket
  define_rule start: '--'
  define_rule start: '/\*', stop: '\*/', type: BLOCK_COMMENT
end
