class StripComment::Scanner::Markdown < StripComment::Scanner
  disable!
  filename /\.(md|markdown|mkd)$/
  filetype 'markdown'
end
