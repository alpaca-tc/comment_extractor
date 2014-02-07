class StripComment::Scanner::Tex < StripComment::Scanner
  disable!
  filename /\.tex$/
  filetype 'tex'
end
