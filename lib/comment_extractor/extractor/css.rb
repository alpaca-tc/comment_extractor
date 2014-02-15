class CommentExtractor::Extractor::Css < CommentExtractor::Extractor
  filename /\.css$/
  filetype 'css'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
