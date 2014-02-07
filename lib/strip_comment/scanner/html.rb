class StripComment::Scanner::Html < StripComment::Scanner
  disable!
  filename /\.html$/
  filetype 'html'
end
