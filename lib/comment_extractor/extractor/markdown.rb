require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Markdown < CommentExtractor::Extractor
  disable!
  filename /\.(?:md|markdown|mkd)$/
  filetype 'markdown'
end
