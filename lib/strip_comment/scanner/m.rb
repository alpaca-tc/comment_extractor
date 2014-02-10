# Objective-C
class CommentParser::Scanner::M < CommentParser::Scanner
  filename /\.m$/
  filetype 'm'

  include CommentParser::Scanner::Concerns::SlashScanner
end
