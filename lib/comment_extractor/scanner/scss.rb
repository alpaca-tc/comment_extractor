class CommentExtractor::Scanner::Scss < CommentExtractor::Scanner
  filename /\.scss$/
  filetype 'scss'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
