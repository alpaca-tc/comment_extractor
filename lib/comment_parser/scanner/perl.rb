class CommentParser::Scanner::Perl < CommentParser::Scanner
  disable!
  filename /\.(pm|pl)$/
  filetype 'perl'
end
