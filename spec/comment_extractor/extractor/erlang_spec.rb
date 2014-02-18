require 'spec_helper'
require 'comment_extractor/extractor/erlang'

class CommentExtractor::Extractor
  describe Erlang do
    it_behaves_like 'detecting shebang', '/usr/bin/env escript'
    it_behaves_like 'extracting comments from', 'erlang.es'
    it_behaves_like 'detecting filename', 'file.es'
  end
end
