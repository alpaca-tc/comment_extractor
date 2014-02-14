class CommentExtractor::Scanner::Markdown < CommentExtractor::Scanner
  disable!
  filename /\.(md|markdown|mkd)$/
  filetype 'markdown'
end
