require 'spec_helper'
require 'comment_extractor/extractor/sass'

class CommentExtractor::Extractor
  describe Sass do
    it_behaves_like 'extracting comments from', 'sass.sass'
    it_behaves_like 'detecting filename', 'file.sass'
  end
end
