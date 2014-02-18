require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Coffee < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.coffee$/
  filetype 'coffee'

  define_default_bracket
  define_regexp_bracket
  comment start_with: '###', end_with: '###', type: BLOCK_COMMENT
  comment start_with: '#'
end
