require 'spec_helper'
require 'comment_extractor/extractor/shell'

class CommentExtractor::Extractor
  describe Shell do
    it_behaves_like 'extracting comments from', 'shell.sh'
  end
end
