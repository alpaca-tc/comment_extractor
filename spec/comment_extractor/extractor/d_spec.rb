require 'spec_helper'
require 'comment_extractor/extractor/d'

class CommentExtractor::Extractor
  describe D do
    it_behaves_like 'detecting shebang', '/usr/local/bin/dmd'
    it_behaves_like 'extracting comments from', 'd.d'
  end
end
