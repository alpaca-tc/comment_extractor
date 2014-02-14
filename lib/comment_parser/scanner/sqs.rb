class CommentExtractor::Scanner::Sqs < CommentExtractor::Scanner
  disable!
  filename /\.sqs$/
  filetype 'sqs'
end
