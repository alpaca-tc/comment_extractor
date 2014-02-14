require 'spec_helper'

class CommentExtractor::Scanner
  describe Perl do
    let(:file_path) { 'perl.pl' }
    it_behaves_like 'scanning source code'
  end
end
