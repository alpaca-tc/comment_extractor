require 'spec_helper'

class CommentParser::Scanner
  describe Cs do
    let(:file_path) { 'cs.cs' }
    it_behaves_like 'scanning source code'
  end
end
