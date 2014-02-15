class CommentExtractor::Extractor::Sass < CommentExtractor::Extractor
  filename /\.sass$/
  filetype 'sass'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
