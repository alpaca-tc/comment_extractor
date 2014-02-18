require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Class < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SlashExtractor

  filename /\.class$/
  filetype 'class'
end
