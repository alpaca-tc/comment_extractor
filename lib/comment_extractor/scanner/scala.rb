class CommentExtractor::Scanner::Scala < CommentExtractor::Scanner
  filename /\.scala$/
  filetype 'scala'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
