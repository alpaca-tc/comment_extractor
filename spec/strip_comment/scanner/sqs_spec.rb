require 'spec_helper'

class StripComment::Scanner
  describe Sqs do
    subject { Sqs }
    it { pending 'Implementation scanner' }
    its(:disabled?) { should be_true }
  end
end
