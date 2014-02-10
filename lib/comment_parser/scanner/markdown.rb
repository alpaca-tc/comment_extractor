class CommentParser::Scanner::Markdown < CommentParser::Scanner
  disable!
  filename /\.(md|markdown|mkd)$/
  filetype 'markdown'
end
