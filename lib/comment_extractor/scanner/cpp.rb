class CommentExtractor::Scanner::Cpp < CommentExtractor::Scanner
  filename /\.cpp$/
  filetype 'cpp'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
