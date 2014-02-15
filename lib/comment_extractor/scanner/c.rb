# [todo] - re-architect
class CommentExtractor::Scanner::C < CommentExtractor::Scanner
  filename /\.c$/
  filetype 'c'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
