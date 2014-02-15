require 'comment_extractor/extractor/sqs'

class CommentExtractor::Extractor::Sqs < CommentExtractor::Extractor
  disable!
  filename /\.sqs$/
  filetype 'sqs'
end
