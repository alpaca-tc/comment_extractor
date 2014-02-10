class CommentParser::Scanner::Cc < CommentParser::Scanner
  filename /\.cc$/
  filetype 'cc'

  include CommentParser::Scanner::Concerns::SlashScanner
end
