require 'spec_helper'

class CommentExtractor::Scanner
  describe Fortran do
    let(:file_path) { 'fortran.f' }
    it_behaves_like 'scanning source code'
  end
end
