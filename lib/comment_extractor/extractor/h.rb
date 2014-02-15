require 'comment_extractor/extractor'

class CommentExtractor::Extractor::H < CommentExtractor::Extractor
  filename /\.h$/
  filetype 'h'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
