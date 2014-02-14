class CommentExtractor::Scanner::Go < CommentExtractor::Scanner
  filename /\.go$/
  filetype 'go'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
