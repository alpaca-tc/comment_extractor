require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Scala < CommentExtractor::Extractor
  filename /\.scala$/
  filetype 'scala'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
