class CommentExtractor::Extractor::Scss < CommentExtractor::Extractor
  filename /\.scss$/
  filetype 'scss'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
