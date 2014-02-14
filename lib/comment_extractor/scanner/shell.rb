class CommentExtractor::Scanner::Shell < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.(zsh|bash|sh)$/
  filetype '(bash|sh)'

  define_default_bracket
  define_rule start: '#'
end
