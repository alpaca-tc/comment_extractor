class CommentParser::Scanner::Html < CommentParser::Scanner
  disable!
  filename /\.html$/
  filetype 'html'
end
