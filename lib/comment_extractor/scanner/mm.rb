class CommentExtractor::Scanner::Mm < CommentExtractor::Scanner
  filename /\.mm$/
  filetype 'mm'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
