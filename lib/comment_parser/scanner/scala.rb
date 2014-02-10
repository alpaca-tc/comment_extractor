class CommentParser::Scanner::Scala < CommentParser::Scanner
  filename /\.scala$/
  filetype 'scala'

  include CommentParser::Scanner::Concerns::SlashScanner
end
