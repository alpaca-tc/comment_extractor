require 'comment_extractor/extractor/concerns/simple_extractor'

module CommentExtractor::Extractor::Concerns::SlashExtractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  define_default_bracket
  define_rule start: /\/\//
  define_rule start: /\/\*/, stop: /\*\//, type: BLOCK_COMMENT
end
