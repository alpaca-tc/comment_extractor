class CommentExtractor::Scanner::Java < CommentExtractor::Scanner
  filename /\.java$/
  filetype 'java'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
