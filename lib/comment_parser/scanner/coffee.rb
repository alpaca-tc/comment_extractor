class CommentParser::Scanner::Coffee < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.coffee$/
  filetype 'coffee'

  define_default_bracket
  define_regexp_bracket
  define_rule open: '###', close: '###', type: BLOCK_COMMENT
  define_rule open: '#'
end
