class CommentExtractor::Scanner::Css < CommentExtractor::Scanner
  filename /\.css$/
  filetype 'css'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
