require 'strscan'
require 'strip_comment/parser'

class StripComment::Scanner
  attr_accessor :file_object, :content

  def initialize(file_object, content = nil)
    @file_object = file_object
    @content = content
  end

  def scan
    raise 'Neet to implement'
  end

  def content
    @content ||= file_object.respond_to?(:content) ? file_object.content : ''
  end

  autoload :Ruby, 'strip_comment/scanner/ruby'
end

require 'strip_comment/scanner/ruby'
