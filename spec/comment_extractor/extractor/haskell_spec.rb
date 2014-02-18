require 'spec_helper'
require 'comment_extractor/extractor/haskell'

class CommentExtractor::Extractor
  describe Haskell do
    it_behaves_like 'extracting comments from', 'haskell.hs'
    it_behaves_like 'detecting filename', 'file.hs'
  end
end
