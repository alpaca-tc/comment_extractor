require 'spec_helper'

class CommentParser::Scanner
  describe Css do
    let(:file_path) { 'css.css' }
    it_behaves_like 'scanning source code'
  end
end
