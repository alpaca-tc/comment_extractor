class CommentParser::Scanner::Haskell < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.hs$/
  filetype 'haskell'

  define_default_bracket
  define_rule start: '--'
  define_rule start: '{-', stop: '-}', type: BLOCK_COMMENT
end
