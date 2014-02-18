require 'spec_helper'
require 'comment_extractor/extractor/haml'

class CommentExtractor::Extractor
  describe Haml do
    it_behaves_like 'extracting comments from', 'haml.haml'
    it_behaves_like 'detecting filename', 'file.haml'
  end
end
