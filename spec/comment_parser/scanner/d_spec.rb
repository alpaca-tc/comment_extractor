require 'spec_helper'

class CommentParser::Scanner
  describe D do
    let(:file_path) { 'd.d' }
    it_behaves_like 'detecting shebang', '/usr/local/bin/dmd'
    it_behaves_like 'scanning source code'
  end
end
