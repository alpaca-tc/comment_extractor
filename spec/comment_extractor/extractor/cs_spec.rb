require 'spec_helper'
require 'comment_extractor/extractor/cs'

class CommentExtractor::Extractor
  describe Cs do
    it_behaves_like 'extracting comments from', 'cs.cs'
    it_behaves_like 'detecting filename', 'file.cs'
  end
end
