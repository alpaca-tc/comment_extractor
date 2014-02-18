require 'spec_helper'
require 'comment_extractor/extractor/coffee'

class CommentExtractor::Extractor
  describe Coffee do
    it_behaves_like 'extracting comments from', 'coffee.coffee'
    it_behaves_like 'detecting filename', 'file.coffee'
  end
end
