class StripComment::Scanner::Cc < StripComment::Scanner
  filename /\.cc$/
  filetype 'cc'

  include StripComment::Scanner::Concerns::SlashScanner
end
