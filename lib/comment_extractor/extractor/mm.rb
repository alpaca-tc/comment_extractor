class CommentExtractor::Extractor::Mm < CommentExtractor::Extractor
  filename /\.mm$/
  filetype 'mm'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
