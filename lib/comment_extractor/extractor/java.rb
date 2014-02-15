class CommentExtractor::Extractor::Java < CommentExtractor::Extractor
  filename /\.java$/
  filetype 'java'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
