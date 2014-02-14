class CommentExtractor::Scanner::Perl < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.(pm|pl)$/
  filetype 'perl'

  define_default_bracket
  define_rule start: /^=pod/, stop: /^=cut/, type: BLOCK_COMMENT
  define_rule start: '#'
end
