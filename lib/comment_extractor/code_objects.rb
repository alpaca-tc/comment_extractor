module CommentExtractor
  class CodeObjects
    attr_accessor :file, :comments

    def initialize(file: file, comments: [])
      @file = file
      @comments = comments
    end

    def <<(code_object)
      unless code_object.is_a?(CodeObject)
        message = "no implicit conversion of #{code_object.class} into CodeObject"
        raise TypeError, message
      end

      code_object.metadata[:parent] = self

      @comments << code_object
    end
  end
end
