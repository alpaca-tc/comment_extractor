class StripComment::Scanner::C < StripComment::Scanner
  filename /\.c$/
  filetype 'c'

  include StripComment::Scanner::Concerns::SlashScanner
end
