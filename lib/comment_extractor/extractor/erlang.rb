require 'comment_extractor/extractor'

class CommentExtractor::Extractor::Erlang < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  shebang /escript/
  filename /\.(erl|es)$/
  filetype 'erlang'

  define_default_bracket
  define_rule start: /%+/
end
