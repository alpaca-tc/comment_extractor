class StripComment::Scanner::Python < StripComment::Scanner
  disable!
  filename /\.py$/
  filetype 'py'
end
