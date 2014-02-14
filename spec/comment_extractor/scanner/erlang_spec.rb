require 'spec_helper'

class CommentExtractor::Scanner
  describe Erlang do
    let(:file_path) { 'erlang.es' }
    it_behaves_like 'detecting shebang', '/usr/bin/env escript'
    it_behaves_like 'scanning source code'
  end
end
