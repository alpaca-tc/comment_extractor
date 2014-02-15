require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Ruby < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.rb$/
  filetype 'ruby'
  shebang /.*ruby$/

  define_default_bracket
  define_regexp_bracket
  define_rule start: "=begin\n", stop: '=end', type: BLOCK_COMMENT
  define_rule start: '#'
end
