require 'spec_helper'

class CommentExtractor::Extractor
  describe Scala do
    it_behaves_like 'scanning source code'
  end
end
