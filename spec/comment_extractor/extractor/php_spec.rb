require 'spec_helper'
require 'comment_extractor/extractor/php'

class CommentExtractor::Extractor
  describe Php do
    it_behaves_like 'extracting comments from', 'php.php'
  end
end
