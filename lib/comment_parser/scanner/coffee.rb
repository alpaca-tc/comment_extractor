class CommentExtractor::Scanner::Coffee < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.coffee$/
  filetype 'coffee'

  define_default_bracket
  define_regexp_bracket
  define_rule start: '###', stop: '###', type: BLOCK_COMMENT
  define_rule start: '#'
end
