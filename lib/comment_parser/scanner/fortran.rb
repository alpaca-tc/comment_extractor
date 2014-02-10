class CommentParser::Scanner::Fortran < CommentParser::Scanner
  disable!
  filename /\.(f|f90|F|F90)$/
  filetype 'fortran'
end
