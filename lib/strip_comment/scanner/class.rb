class StripComment::Scanner::Class < StripComment::Scanner
  filename /\.class$/
  filetype 'class'

  include StripComment::Scanner::Concerns::SlashScanner
end
