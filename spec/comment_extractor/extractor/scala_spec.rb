require 'spec_helper'
require 'comment_extractor/extractor/scala'

class CommentExtractor::Extractor
  describe Scala do
    it_behaves_like 'extracting comments from', 'scala.scala'
    it_behaves_like 'detecting filename', 'file.scala'
  end
end
