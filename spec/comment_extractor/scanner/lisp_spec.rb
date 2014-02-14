require 'spec_helper'

class CommentExtractor::Scanner
  describe Lisp do
    let(:file_path) { 'lisp.el' }
    it_behaves_like 'scanning source code'
  end
end
