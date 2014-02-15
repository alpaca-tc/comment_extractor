class CommentExtractor::Extractor::Python < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.py$/
  filetype 'py'

  define_default_bracket
  define_rule start: '"""', stop: '"""', type: BLOCK_COMMENT
  define_rule start: '"""', stop: '"""', type: BLOCK_COMMENT
  define_rule start: '#'
end
