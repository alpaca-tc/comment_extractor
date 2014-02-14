require 'spec_helper'

class CommentExtractor::Scanner
  describe Cpp do
    let(:file_path) { 'cpp.cpp' }
    it_behaves_like 'scanning source code'
  end
end
