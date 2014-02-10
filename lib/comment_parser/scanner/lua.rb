class CommentParser::Scanner::Lua < CommentParser::Scanner
  disable!
  filename /\.lua$/
  filetype 'lua'
end
