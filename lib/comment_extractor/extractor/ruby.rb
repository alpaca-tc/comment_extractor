require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Ruby < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.rb$/
  filetype 'ruby'
  shebang /.*ruby$/

  define_default_bracket
  define_regexp_bracket
  comment start_with: "=begin\n", end_with: '=end', type: BLOCK_COMMENT
  comment start_with: '#'
end
