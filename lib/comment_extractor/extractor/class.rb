class CommentExtractor::Extractor::Class < CommentExtractor::Extractor
  filename /\.class$/
  filetype 'class'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
