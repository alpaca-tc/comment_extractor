require 'spec_helper'
require 'comment_extractor/extractor/java'

class CommentExtractor::Extractor
  describe Java do
    it_behaves_like 'extracting comments from', 'java.java'
  end
end
