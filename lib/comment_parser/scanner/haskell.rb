class CommentParser::Scanner::Haskell < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.hs$/
  filetype 'haskell'

  rule = {
    single_line: { open: '--' },
    multi_line: { open: '{-', close: '-}' }
  }
  self.define_rule rule
end
