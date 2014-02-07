class StripComment::Scanner::H < StripComment::Scanner
  filename /\.h$/
  filetype 'h'

  include StripComment::Scanner::Concerns::SlashScanner
end
