class CommentExtractor::Scanner::Class < CommentExtractor::Scanner
  filename /\.class$/
  filetype 'class'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
