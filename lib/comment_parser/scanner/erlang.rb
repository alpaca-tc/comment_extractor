class CommentExtractor::Scanner::Erlang < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  shebang /escript/
  filename /\.(erl|es)$/
  filetype 'erlang'

  define_default_bracket
  define_rule start: /%+/
end
