class CommentExtractor::Scanner::Ruby < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.rb$/
  filetype 'ruby'
  shebang /.*ruby$/

  define_default_bracket
  define_regexp_bracket
  define_rule start: "=begin\n", stop: '=end', type: BLOCK_COMMENT
  define_rule start: '#'
end
