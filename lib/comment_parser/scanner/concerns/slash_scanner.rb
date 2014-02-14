require 'comment_extractor/scanner/concerns/simple_scanner'

module CommentExtractor::Scanner::Concerns::SlashScanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  define_default_bracket
  define_rule start: /\/\//
  define_rule start: /\/\*/, stop: /\*\//, type: BLOCK_COMMENT
end
