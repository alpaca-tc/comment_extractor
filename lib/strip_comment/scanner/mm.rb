class StripComment::Scanner::Mm < StripComment::Scanner
  filename /\.mm$/
  filetype 'mm'

  include StripComment::Scanner::Concerns::SlashScanner
end
