# [todo] - re-architect
class CommentExtractor::Extractor::C < CommentExtractor::Extractor
  filename /\.c$/
  filetype 'c'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
