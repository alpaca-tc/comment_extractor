class CommentExtractor::Scanner::Html < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

  filename /\.html$/
  filetype 'html'

  define_default_bracket
  define_ignore_patterns /<\s*script[^>]*>.*?<\/script\s*>/mi

  define_rule start: '<!--', stop: '-->', type: BLOCK_COMMENT

  def content
    @content ||= super.gsub(/&\w+;/, '')
  end
end