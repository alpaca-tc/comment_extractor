require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Html < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.html$/
  filetype 'html'

  define_default_bracket
  define_ignore_patterns /<\s*script[^>]*>.*?<\/script\s*>/mi

  comment start_with: '<!--', end_with: '-->', type: BLOCK_COMMENT
end
