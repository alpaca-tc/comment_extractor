class StripComment::Scanner::Markdown < StripComment::Scanner
  filename /\.(md|markdown|mkd)$/
  filetype 'markdown'
end
