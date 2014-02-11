require 'spec_helper'

class CommentParser::Scanner
  describe Coffee do
    let(:file_path) { 'coffee.coffee' }
    it_behaves_like 'scanning source code'
  end
end
