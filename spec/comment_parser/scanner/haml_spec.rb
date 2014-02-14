require 'spec_helper'

class CommentExtractor::Scanner
  describe Haml do
    let(:file_path) { 'haml.haml' }
    it_behaves_like 'scanning source code'
  end
end
