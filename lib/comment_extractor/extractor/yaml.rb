require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Yaml < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  filename /\.yaml$/
  filetype 'yaml'

  define_ignore_patterns /^\s*[^#]+$/
  comment start_with: /^s*#/
  comment start_with: /\s#(?=[^#]*)$/
end
