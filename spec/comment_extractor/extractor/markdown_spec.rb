require 'spec_helper'
require 'comment_extractor/extractor/markdown'

class CommentExtractor::Extractor
  describe Markdown, disabled: true do
    it_behaves_like 'detecting filename', 'file.mkd', 'file.md', 'file.markdown'
  end
end
