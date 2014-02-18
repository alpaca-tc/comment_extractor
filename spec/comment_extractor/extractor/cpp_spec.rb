require 'spec_helper'
require 'comment_extractor/extractor/cpp'

class CommentExtractor::Extractor
  describe Cpp do
    it_behaves_like 'extracting comments from', 'cpp.cpp'
    it_behaves_like 'detecting filename', 'file.cpp'
  end
end
