require 'spec_helper'

class CommentExtractor::Extractor
  describe Class do
    # [todo] - Please give me .class sample
    subject { Class }
    it { should include Concerns::SlashExtractor }
  end
end
