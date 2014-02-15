require 'spec_helper'

class CommentExtractor::Extractor
  describe Clojure do
    let(:file_path) { 'clojure.clj' }
    it_behaves_like 'scanning source code'
  end
end
