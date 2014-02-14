class CommentExtractor::Scanner::Fortran < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.(f|f90|F|F90)$/
  filetype 'fortran'

  define_default_bracket
  define_rule start: '!'
end
