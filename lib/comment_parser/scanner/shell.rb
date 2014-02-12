class CommentParser::Scanner::Shell < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.(zsh|bash|sh)$/
  filetype '(bash|sh)'

  define_default_bracket
  define_rule open: '#'
end
