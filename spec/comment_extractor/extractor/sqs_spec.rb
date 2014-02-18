require 'spec_helper'
require 'comment_extractor/extractor/sqs'

class CommentExtractor::Extractor
  describe Sqs, disabled: true do
    pending 'Please give me sample code'
    it_behaves_like 'detecting filename', 'file.sqs'
  end
end
