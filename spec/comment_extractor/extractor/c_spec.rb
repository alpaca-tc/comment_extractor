require 'spec_helper'
require 'comment_extractor/extractor/c'

class CommentExtractor::Extractor
  describe C do
    it_behaves_like 'extracting comments from', 'c.c'
  end
end
