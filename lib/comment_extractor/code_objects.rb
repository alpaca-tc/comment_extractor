require 'forwardable'

module CommentExtractor
  class CodeObjects
    extend Forwardable

    attr_accessor :file

    def initialize(file: nil)
      @file = file
      @code_objects = []
    end

    def <<(code_object)
      unless code_object.is_a?(CodeObject)
        message = "no implicit conversion of #{code_object.class} into CodeObject"
        raise TypeError, message
      end

      code_object.metadata[:parent] = self

      @code_objects << code_object
    end

    def_delegators :@code_objects, :[], :size, :length, :each, :map, :each_with_index, :each_with_object, :map!
  end
end
