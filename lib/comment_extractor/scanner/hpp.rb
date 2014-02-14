class CommentExtractor::Scanner::Hpp < CommentExtractor::Scanner
  filename /\.hpp$/
  filetype 'hpp'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
