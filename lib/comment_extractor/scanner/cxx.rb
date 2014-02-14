class CommentExtractor::Scanner::Cxx < CommentExtractor::Scanner
  filename /\.cxx$/
  filetype 'cxx'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
