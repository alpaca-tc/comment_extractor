class CommentExtractor::Scanner::Lua < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.lua$/
  filetype 'lua'

  define_default_bracket
  define_rule start: '--\[\[', stop: /\s*\]\]/, type: BLOCK_COMMENT
  define_rule start: '--'
end
