class CommentExtractor::Scanner::Cs < CommentExtractor::Scanner
  filename /\.cs$/
  filetype 'cs'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
