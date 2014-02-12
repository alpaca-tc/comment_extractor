module CommentParser::Scanner::Concerns::SlashScanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  define_default_bracket
  define_rule start: /\/\//
  define_rule start: /\/\*/, stop: /\*\//, type: BLOCK_COMMENT
end
