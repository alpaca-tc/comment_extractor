class CommentExtractor::Scanner::Sass < CommentExtractor::Scanner
  filename /\.sass$/
  filetype 'sass'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
