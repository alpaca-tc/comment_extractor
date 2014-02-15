require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Perl < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.(pm|pl)$/
  filetype 'perl'

  define_default_bracket
  define_rule start: /^=pod/, stop: /^=cut/, type: BLOCK_COMMENT
  define_rule start: '#'
end
