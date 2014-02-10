class CommentParser::Scanner::Vim < CommentParser::Scanner
  disable!
  filename /\.vim$/
  filetype 'vim'
end
