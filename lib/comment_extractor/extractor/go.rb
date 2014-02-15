require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Go < CommentExtractor::Extractor
  filename /\.go$/
  filetype 'go'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
