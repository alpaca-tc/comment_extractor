require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Sqs < CommentExtractor::Extractor
  disable!
  filename /\.sqs$/
  filetype 'sqs'
end
