class StripComment::Scanner::Hpp < StripComment::Scanner
  filename /\.hpp$/
  filetype 'hpp'

  include StripComment::Scanner::Concerns::SlashScanner
end
