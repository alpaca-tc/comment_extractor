class CommentExtractor::Scanner::Cc < CommentExtractor::Scanner
  filename /\.cc$/
  filetype 'cc'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
