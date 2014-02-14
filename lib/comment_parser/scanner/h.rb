class CommentExtractor::Scanner::H < CommentExtractor::Scanner
  filename /\.h$/
  filetype 'h'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
