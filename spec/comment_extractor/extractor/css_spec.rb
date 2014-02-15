require 'spec_helper'

class CommentExtractor::Extractor
  describe Css do
    let(:file_path) { 'css.css' }
    it_behaves_like 'scanning source code'
  end
end
