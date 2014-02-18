require 'comment_extractor/extractor'
require 'comment_extractor/extractor/concerns/simple_extractor'

module CommentExtractor
  class Extractor
    module Concerns
      module SlashExtractor
        include CommentExtractor::Extractor::Concerns::SimpleExtractor

        define_default_bracket
        comment start_with: /\/\//
        comment start_with: /\/\*/, end_with: /\*\//, type: BLOCK_COMMENT
      end
    end
  end
end
