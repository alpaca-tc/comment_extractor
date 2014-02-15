require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Cs < CommentExtractor::Extractor
  filename /\.cs$/
  filetype 'cs'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
