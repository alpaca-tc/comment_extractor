require 'spec_helper'
require 'comment_extractor/extractor/tex'

class CommentExtractor::Extractor
  describe Tex do
    it_behaves_like 'extracting comments from', 'tex.tex'
    it_behaves_like 'detecting filename', 'file.tex'
  end
end
