class CommentParser::Scanner::Haml < CommentParser::Scanner
  disable!
  filename /\.haml$/
  filetype 'haml'
end
