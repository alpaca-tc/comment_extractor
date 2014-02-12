require 'spec_helper'

class CommentParser::Scanner
  describe Lisp do
    let(:file_path) { 'lisp.el' }
    it_behaves_like 'scanning source code'
  end
end
