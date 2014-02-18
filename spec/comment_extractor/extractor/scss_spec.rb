require 'spec_helper'
require 'comment_extractor/extractor/scss'

class CommentExtractor::Extractor
  describe Scss do
    it_behaves_like 'extracting comments from', 'scss.scss'
    it_behaves_like 'detecting filename', 'file.scss'
  end
end
