class CommentParser::Scanner::Python < CommentParser::Scanner
  disable!
  filename /\.py$/
  filetype 'py'
end
