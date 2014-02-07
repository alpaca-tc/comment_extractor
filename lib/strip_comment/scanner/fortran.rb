class StripComment::Scanner::Fortran < StripComment::Scanner
  disable!
  filename /\.(f|f90|F|F90)$/
  filetype 'fortran'
end
