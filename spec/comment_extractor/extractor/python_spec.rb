require 'spec_helper'
require 'comment_extractor/extractor/python'

class CommentExtractor::Extractor
  describe Python do
    it_behaves_like 'extracting comments from', 'python.py'
  end
end
