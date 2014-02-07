class StripComment::Scanner::Scala < StripComment::Scanner
  filename /\.scala$/
  filetype 'scala'

  include StripComment::Scanner::Concerns::SlashScanner
end
