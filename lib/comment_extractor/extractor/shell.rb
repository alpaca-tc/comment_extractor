class CommentExtractor::Extractor::Shell < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.(zsh|bash|sh)$/
  filetype '(bash|sh)'

  define_default_bracket
  define_rule start: '#'
end
