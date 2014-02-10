class CommentParser::Scanner::Haskell < CommentParser::Scanner
  disable!
  filename /\.hs$/
  filetype 'haskell'
end
