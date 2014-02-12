class CommentParser::Scanner::Haskell < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.hs$/
  filetype 'haskell'

  define_default_bracket
  define_rule open: '--'
  define_rule open: '{-', close: '-}', type: BLOCK_COMMENT
end
