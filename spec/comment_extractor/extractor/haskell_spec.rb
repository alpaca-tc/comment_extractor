require 'spec_helper'

class CommentExtractor::Extractor
  describe Haskell do
    let(:file_path) { 'haskell.hs' }
    it_behaves_like 'scanning source code'
  end
end
