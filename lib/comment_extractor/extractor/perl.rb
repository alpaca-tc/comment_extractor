require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Perl < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.(?:pm|pl)$/
  filetype 'perl'

  define_default_bracket
  comment start_with: /^=pod/, end_with: /^=cut/, type: BLOCK_COMMENT
  comment start_with: '#'
end
