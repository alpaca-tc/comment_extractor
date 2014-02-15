require 'spec_helper'

class CommentExtractor::Extractor
  describe Shell do
    it_behaves_like 'scanning source code'
  end
end
