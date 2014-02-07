class StripComment::Scanner::Sass < StripComment::Scanner
  filename /\.sass$/
  filetype 'sass'

  include StripComment::Scanner::Concerns::SlashScanner
end
