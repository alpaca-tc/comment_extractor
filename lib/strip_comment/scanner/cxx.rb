class StripComment::Scanner::Cxx < StripComment::Scanner
  filename /\.cxx$/
  filetype 'cxx'

  include StripComment::Scanner::Concerns::SlashScanner
end
