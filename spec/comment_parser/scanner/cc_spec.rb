require 'spec_helper'

class CommentParser::Scanner
  describe Cc do
    let(:file_path) { 'cc.cc' }
    it_behaves_like 'scanning source code'
  end
end
