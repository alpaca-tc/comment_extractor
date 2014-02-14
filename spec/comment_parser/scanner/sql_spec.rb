require 'spec_helper'

class CommentExtractor::Scanner
  describe Sql do
    it_behaves_like 'scanning source code'
  end
end
