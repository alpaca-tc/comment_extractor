class CommentExtractor::Scanner::D < CommentExtractor::Scanner
  shebang /\/dmd/
  filename /\.d$/
  filetype 'd'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
