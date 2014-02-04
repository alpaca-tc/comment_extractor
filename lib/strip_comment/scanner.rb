require 'strscan'

class StripComment::Scanner
  attr_accessor :content

  def initialize(content)
    @content = content
  end

  def scan
    raise 'Neet to implement'
  end

  autoload :Ruby, 'strip_comment/scanner/ruby'
end
