require 'spec_helper'

class CommentParser::Scanner
  describe C do
    let(:file_path) { 'c.c' }
    it_behaves_like 'scanning source code'
  end
end
