class CommentExtractor::Scanner::Sql < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.sql$/
  filetype 'sql'

  define_default_bracket
  define_rule start: '--'
  define_rule start: '/\*', stop: '\*/', type: BLOCK_COMMENT
end
