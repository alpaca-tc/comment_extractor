class StripComment::Scanner::Java < StripComment::Scanner
  filename /\.java$/
  filetype 'java'

  include StripComment::Scanner::Concerns::SlashScanner
end
