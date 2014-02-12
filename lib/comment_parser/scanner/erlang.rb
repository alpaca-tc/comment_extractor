class CommentParser::Scanner::Erlang < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  shebang /escript/
  filename /\.(erl|es)$/
  filetype 'erlang'

  define_default_bracket
  define_rule open: /%+/
end
