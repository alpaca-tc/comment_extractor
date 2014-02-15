class CommentExtractor::Extractor::Lua < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.lua$/
  filetype 'lua'

  define_default_bracket
  define_rule start: '--\[\[', stop: /\s*\]\]/, type: BLOCK_COMMENT
  define_rule start: '--'
end
