class CommentParser::Scanner::Sql < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.sql$/
  filetype 'sql'

  define_default_bracket
  define_rule open: '--'
  define_rule open: '/\*', close: '\*/', type: BLOCK_COMMENT
end
