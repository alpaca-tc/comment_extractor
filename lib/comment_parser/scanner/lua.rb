class CommentParser::Scanner::Lua < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.lua$/
  filetype 'lua'

  define_default_bracket
  define_rule start: '--\[\[', stop: /\s*\]\]/, type: BLOCK_COMMENT
  define_rule start: '--'
end
