require 'spec_helper'

class CommentParser::Scanner
  describe Fortran do
    let(:file_path) { 'fortran.f' }
    it_behaves_like 'scanning source code'
  end
end
