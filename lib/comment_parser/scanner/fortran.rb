class CommentParser::Scanner::Fortran < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.(f|f90|F|F90)$/
  filetype 'fortran'

  define_default_bracket
  define_rule open: '!'
end
