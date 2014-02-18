require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Shell < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /(?:\.(?:zsh|bash|sh)|zshrc|bashrc)$/
  filetype %w[bash sh zsh]

  define_default_bracket
  comment start_with: '#'
end
