require 'spec_helper'

class CommentExtractor::Extractor
  describe Haml do
    let(:file_path) { 'haml.haml' }
    it_behaves_like 'scanning source code'
  end
end
