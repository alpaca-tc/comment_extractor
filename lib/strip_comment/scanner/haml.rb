class StripComment::Scanner::Haml < StripComment::Scanner
  disable!
  filename /\.haml$/
  filetype 'haml'
end
