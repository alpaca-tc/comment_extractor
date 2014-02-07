class StripComment::Scanner::Css < StripComment::Scanner
  filename /\.css$/
  filetype 'css'

  include StripComment::Scanner::Concerns::SlashScanner
end
