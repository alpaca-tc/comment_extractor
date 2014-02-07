require 'spec_helper'

class StripComment::Scanner
  describe Markdown do
    subject { Markdown }
    it { pending 'Implementation scanner' }
    its(:disabled?) { should be_true }
  end
end
