class CommentExtractor::Extractor::Cxx < CommentExtractor::Extractor
  filename /\.cxx$/
  filetype 'cxx'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
