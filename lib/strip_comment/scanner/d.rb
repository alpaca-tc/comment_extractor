class StripComment::Scanner::D < StripComment::Scanner
  filename /\.d$/
  filetype 'd'

  include StripComment::Scanner::Concerns::SlashScanner
end
