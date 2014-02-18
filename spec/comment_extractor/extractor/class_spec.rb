require 'spec_helper'
require 'comment_extractor/extractor/class'

class CommentExtractor::Extractor
  describe Class do
    pending 'Please give me a sample file'
    it_behaves_like 'detecting filename', 'file.class'
  end
end
