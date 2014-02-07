class StripComment::Scanner::Scss < StripComment::Scanner
  filename /\.scss$/
  filetype 'scss'

  include StripComment::Scanner::Concerns::SlashScanner
end
