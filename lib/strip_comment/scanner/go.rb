class StripComment::Scanner::Go < StripComment::Scanner
  filename /\.go$/
  filetype 'go'

  include StripComment::Scanner::Concerns::SlashScanner
end
