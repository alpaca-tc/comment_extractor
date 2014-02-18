require 'spec_helper'
require 'comment_extractor/extractor/fortran'

class CommentExtractor::Extractor
  describe Fortran do
    it_behaves_like 'extracting comments from', 'fortran.f'
    it_behaves_like 'detecting filename', 'file.f'
  end
end
