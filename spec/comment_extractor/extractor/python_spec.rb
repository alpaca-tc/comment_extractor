require 'spec_helper'

class CommentExtractor::Extractor
  describe Python do
    it_behaves_like 'scanning source code'
  end
end
