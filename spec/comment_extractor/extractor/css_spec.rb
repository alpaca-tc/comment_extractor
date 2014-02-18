require 'spec_helper'
require 'comment_extractor/extractor/css'

class CommentExtractor::Extractor
  describe Css do
    it_behaves_like 'extracting comments from', 'css.css'
    it_behaves_like 'detecting filename', 'file.css'
  end
end
