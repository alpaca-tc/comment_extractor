require 'spec_helper'

class CommentExtractor::Extractor
  describe Cs do
    let(:file_path) { 'cs.cs' }
    it_behaves_like 'scanning source code'
  end
end
