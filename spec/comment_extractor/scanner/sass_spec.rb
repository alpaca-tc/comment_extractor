require 'spec_helper'

class CommentExtractor::Scanner
  describe Sass do
    let(:file_path) { 'sass.sass' }
    it_behaves_like 'scanning source code'
  end
end
