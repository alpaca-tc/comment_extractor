require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Text < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.txt$/
  filetype 'text'

  comment start_with: /#/
end
