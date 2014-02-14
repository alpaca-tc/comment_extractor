require 'spec_helper'

class CommentExtractor::Scanner
  describe Go do
    let(:file_path) { 'golang.go' }
    it_behaves_like 'scanning source code'
  end
end
