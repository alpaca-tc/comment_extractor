require 'spec_helper'
require 'comment_extractor/extractor/clojure'

class CommentExtractor::Extractor
  describe Clojure do
    it_behaves_like 'extracting comments from', 'clojure.clj'
    it_behaves_like 'detecting filename', 'file.clj'
  end
end
