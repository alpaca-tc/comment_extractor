class CommentParser::Scanner::Html < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.html$/
  filetype 'html'

  define_default_bracket
  define_ignore_patterns /<\s*script[^>]*>.*?<\/script\s*>/mi

  define_rule open: '<!--', close: '-->', type: BLOCK_COMMENT

  def content
    @content ||= super.gsub(/&\w+;/, '')
  end
end
