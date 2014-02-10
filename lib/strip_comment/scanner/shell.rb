class CommentParser::Scanner::Shell < CommentParser::Scanner
  disable!
  filename /\.(zsh|bash|sh)$/
  filetype '(bash|sh)'
end
