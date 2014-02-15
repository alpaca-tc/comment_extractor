require 'spec_helper'
require 'comment_extractor/extractor/lisp'

class CommentExtractor::Extractor
  describe Lisp do
    it_behaves_like 'extracting comments from', 'lisp.el'
  end
end
