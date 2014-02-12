class CommentParser::Scanner::Python < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.py$/
  filetype 'py'

  define_default_bracket
  define_rule open: '"""', close: '"""', type: BLOCK_COMMENT
  define_rule open: '"""', close: '"""', type: BLOCK_COMMENT
  define_rule open: '#'
end
