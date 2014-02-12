class CommentParser::Scanner::Html < CommentParser::Scanner
  disable!
  filename /\.html$/
  filetype 'html'

  # include CommentParser::Scanner::Concerns::SimpleScanner
  #
  # define_default_bracket
  # define_regexp_bracket
  # define_rule open: '<!--', close: '-->', type: BLOCK_COMMENT
end
