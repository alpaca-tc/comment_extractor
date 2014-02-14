require 'spec_helper'

class CommentExtractor::Scanner
  describe Html do
    let(:file_path) { 'html.html' }
    it_behaves_like 'scanning source code'
  end
end
