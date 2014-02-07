class StripComment::Scanner::Fortran < StripComment::Scanner
  filename /\.(f|f90|F|F90)$/
  filetype 'fortran'

  include StripComment::Scanner::Concerns::SlashScanner
end
