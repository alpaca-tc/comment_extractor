require 'active_support/core_ext/class/attribute_accessors'

class StripComment::CodeObject
  cattr_accessor :file, :metadata, :value

  def initialize
    self.file = nil
    self.value = nil
    self.metadata = {}
  end

  autoload :Comment, 'strip_comment/code_object/comment'
end
