class StripComment::Scanner::Haskell < StripComment::Scanner
  disable!
  filename /\.hs$/
  filetype 'haskell'
end
