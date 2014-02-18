require 'spec_helper'
require 'comment_extractor/extractor/php'

class CommentExtractor::Extractor
  describe Php do
    it_behaves_like 'extracting comments from', 'php.php'
    it_behaves_like 'detecting filename', 'file.php'
  end
end
