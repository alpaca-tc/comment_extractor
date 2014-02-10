class CommentParser::Scanner::Tex < CommentParser::Scanner
  disable!
  filename /\.tex$/
  filetype 'tex'
end
