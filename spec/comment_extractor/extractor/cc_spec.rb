require 'spec_helper'
require 'comment_extractor/extractor/cc'

class CommentExtractor::Extractor
  describe Cc do
    it_behaves_like 'extracting comments from', 'cc.cc'
  end
end
