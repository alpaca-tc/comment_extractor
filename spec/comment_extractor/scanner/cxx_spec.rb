require 'spec_helper'

class CommentExtractor::Scanner
  describe Cxx do
    subject { Cxx }
    it { should include Concerns::SlashScanner }
  end
end
