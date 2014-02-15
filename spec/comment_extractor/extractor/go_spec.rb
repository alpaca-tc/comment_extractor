require 'spec_helper'
require 'comment_extractor/extractor/go'

class CommentExtractor::Extractor
  describe Go do
    it_behaves_like 'extracting comments from', 'golang.go'
  end
end
