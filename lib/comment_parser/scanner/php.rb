class CommentExtractor::Scanner::Php < CommentExtractor::Scanner
  filename /\.php$/
  filetype 'php'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
