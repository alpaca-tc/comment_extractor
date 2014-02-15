require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Sqf < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SlashExtractor

  filename /\.sqf$/
  filetype 'sqf'
end
