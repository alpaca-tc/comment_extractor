class StripComment::Scanner::JavaScript < StripComment::Scanner
  filename /\.js$/
  filetype 'javascript'
  shebang /.*(js|node)$/

  include StripComment::Scanner::Concerns::SlashScanner
end
