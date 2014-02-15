require 'spec_helper'
require 'comment_extractor/extractor/css'

class CommentExtractor::Extractor
  describe Css do
    it_behaves_like 'extracting comments from', 'css.css'
  end
end
