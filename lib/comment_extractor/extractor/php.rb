require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Php < CommentExtractor::Extractor
  filename /\.php$/
  filetype 'php'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
