# Objective-C
class CommentExtractor::Extractor::M < CommentExtractor::Extractor
  filename /\.m$/
  filetype 'm'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
