require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Cc < CommentExtractor::Extractor
  filename /\.cc$/
  filetype 'cc'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
