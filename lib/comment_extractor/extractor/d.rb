class CommentExtractor::Extractor::D < CommentExtractor::Extractor
  shebang /\/dmd/
  filename /\.d$/
  filetype 'd'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
