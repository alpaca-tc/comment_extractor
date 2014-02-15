require 'spec_helper'
require 'comment_extractor/extractor/html'

class CommentExtractor::Extractor
  describe Html do
    it_behaves_like 'extracting comments from', 'html.html'
  end
end
