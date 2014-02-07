class StripComment::Scanner::Cs < StripComment::Scanner
  filename /\.cs$/
  filetype 'cs'

  include StripComment::Scanner::Concerns::SlashScanner
end
