require 'spec_helper'

class CommentParser::Scanner
  describe Html do
    let(:file_path) { 'html.html' }
    it_behaves_like 'scanning source code'
  end
end
