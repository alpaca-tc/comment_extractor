class CommentExtractor::Extractor::Hpp < CommentExtractor::Extractor
  filename /\.hpp$/
  filetype 'hpp'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
