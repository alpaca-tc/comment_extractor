# Objective-C
class CommentExtractor::Scanner::M < CommentExtractor::Scanner
  filename /\.m$/
  filetype 'm'

  include CommentExtractor::Scanner::Concerns::SlashScanner
end
