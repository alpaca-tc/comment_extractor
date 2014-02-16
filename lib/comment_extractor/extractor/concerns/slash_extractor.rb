require 'comment_extractor/extractor'
require 'comment_extractor/extractor/concerns/simple_extractor'

module CommentExtractor
  class Extractor
    module Concerns
      module SlashExtractor
        include CommentExtractor::Extractor::Concerns::SimpleExtractor

        define_default_bracket
        define_rule start: /\/\//
        define_rule start: /\/\*/, stop: /\*\//, type: BLOCK_COMMENT
      end
    end
  end
end
