require 'spec_helper'

class CommentExtractor::Scanner
  describe Scala do
    it_behaves_like 'scanning source code'
  end
end
