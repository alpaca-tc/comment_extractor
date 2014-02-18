require 'spec_helper'
require 'comment_extractor/extractor/java'

class CommentExtractor::Extractor
  describe Java do
    it_behaves_like 'extracting comments from', 'java.java'
    it_behaves_like 'detecting filename', 'file.java'
  end
end
