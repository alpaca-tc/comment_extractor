require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Coffee < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.coffee$/
  filetype 'coffee'

  define_default_bracket
  define_regexp_bracket
  define_rule start: '###', stop: '###', type: BLOCK_COMMENT
  define_rule start: '#'
end
