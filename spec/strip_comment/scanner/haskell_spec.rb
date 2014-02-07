require 'spec_helper'

class StripComment::Scanner
  describe Haskell do
    subject { Haskell }
    it { pending 'Implementation scanner' }
    its(:disabled?) { should be_true }
  end
end
