# Objective-C
class StripComment::Scanner::M < StripComment::Scanner
  filename /\.m$/
  filetype 'm'

  include StripComment::Scanner::Concerns::SlashScanner
end
