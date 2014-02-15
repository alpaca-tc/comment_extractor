require 'spec_helper'

class CommentExtractor::Extractor
  describe Java do
    let(:file_path) { 'java.java' }
    it_behaves_like 'scanning source code'
  end
end
