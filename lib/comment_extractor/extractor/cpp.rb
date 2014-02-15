require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Cpp < CommentExtractor::Extractor
  filename /\.cpp$/
  filetype 'cpp'

  include CommentExtractor::Extractor::Concerns::SlashExtractor
end
