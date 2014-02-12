class CommentParser::Scanner::Perl < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.(pm|pl)$/
  filetype 'perl'

  define_default_bracket
  define_rule open: /^=pod/, close: /^=cut/, type: BLOCK_COMMENT
  define_rule open: '#'
end
