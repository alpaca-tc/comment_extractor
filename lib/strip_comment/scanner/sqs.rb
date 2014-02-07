class StripComment::Scanner::Sqs < StripComment::Scanner
  disable!
  filename /\.sqs$/
  filetype 'sqs'
end
