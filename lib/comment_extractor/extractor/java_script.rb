require 'comment_extractor/extractor'

class CommentExtractor::Extractor::JavaScript < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor
  include CommentExtractor::Extractor::Concerns::SlashExtractor

  filename /\.js$/
  filetype 'javascript'
  shebang /.*(?:js|node)$/

  define_regexp_bracket
end
