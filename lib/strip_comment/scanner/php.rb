class StripComment::Scanner::Php < StripComment::Scanner
  filename /\.php$/
  filetype 'php'

  include StripComment::Scanner::Concerns::SlashScanner
end
