require 'spec_helper'

class CommentExtractor::Extractor
  describe Cxx do
    subject { Cxx }
    it { should include Concerns::SlashExtractor }
  end
end
