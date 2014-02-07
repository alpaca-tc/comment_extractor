class StripComment::Scanner::Cpp < StripComment::Scanner
  filename /\.cpp$/
  filetype 'cpp'

  include StripComment::Scanner::Concerns::SlashScanner
end
