class StripComment::Scanner::Php < StripComment::Scanner
  disable!
  filename /\.php$/
  filetype 'php'

  include StripComment::Scanner::Concerns::SlashScanner
end
