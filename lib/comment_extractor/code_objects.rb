require 'delegate'

module CommentExtractor
  class CodeObjects < DelegateClass(Array)
    attr_accessor :file

    def initialize(file: nil)
      @file = file
      super([])
    end

    def <<(code_object)
      super(initialize_code_object(code_object))
    end

    def push(*code_object_array)
      arguments = code_object_array.map { |v| initialize_code_object(v) }
      super(arguments)
    end

    def concat(*code_object_arrays)
      arguments = code_object_arrays.flatten.map { |v| initialize_code_object(v) }
      super(arguments)
    end

    def inspect
      attributes = instance_variables.map { |v| "@#{v}=#{instance_variable_get(v)}" }
      attributes = attributes.empty? ? '' : " #{attributes.join(', ')}"
      object_id = '0x%x' % (self.object_id << 1)
      "#<#{self.class}:#{object_id}#{attributes}>"
    end
    alias :to_s :inspect

    private

    def initialize_code_object(code_object)
      unless code_object.is_a?(CodeObject)
        message = "no implicit conversion of #{code_object.class} into CodeObject"
        raise TypeError, message
      end

      code_object.metadata[:parent] = self
      code_object
    end
  end
end
