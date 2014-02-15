require 'spec_helper'

class CommentExtractor::Extractor
  describe C do
    let(:file_path) { 'c.c' }
    it_behaves_like 'scanning source code'
  end
end
