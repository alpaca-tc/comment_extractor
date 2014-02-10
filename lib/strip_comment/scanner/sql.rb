class CommentParser::Scanner::Sql < CommentParser::Scanner
  disable!
  filename /\.sql$/
  filetype 'sql'
end
