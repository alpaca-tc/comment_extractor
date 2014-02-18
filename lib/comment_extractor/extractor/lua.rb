require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Lua < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.lua$/
  filetype 'lua'

  define_default_bracket
  comment start_with: '--\[\[', end_with: /\s*\]\]/, type: BLOCK_COMMENT
  comment start_with: '--'
end
