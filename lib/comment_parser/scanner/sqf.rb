class CommentExtractor::Scanner::Sqf < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SlashScanner

  filename /\.sqf$/
  filetype 'sqf'
end
