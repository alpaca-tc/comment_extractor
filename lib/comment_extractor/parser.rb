require 'comment_extractor/file'
require 'comment_extractor/extractors'

module CommentExtractor
  class Parser
    attr_accessor :extractor

    def initialize(extractor)
      @extractor = extractor
    end

    def extract_comments
      @extractor.extract_comments
    rescue NoMethodError
      raise TypeError, "#{@extractor} should be a instance of #{Extractor}"
    end

    def self.for(file_path)
      if extractor = Extractors.can_extract(file_path)
        self.initialize_with_extractor(file_path, extractor)
      end
    end

    def self.initialize_with_extractor(file_path, extractor)
      content = File.open(file_path, 'r') { |f| f.read_content }

      # Initialize parser
      code_objects = CodeObjects.new(file: file_path)
      instance_of_extractor = extractor.new(content, code_objects)
      new(instance_of_extractor)
    end
  end
end
