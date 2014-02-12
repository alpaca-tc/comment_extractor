require 'spec_helper'

class CommentParser::Scanner
  describe Perl do
    let(:file_path) { 'perl.pl' }
    it_behaves_like 'scanning source code'
  end
end
