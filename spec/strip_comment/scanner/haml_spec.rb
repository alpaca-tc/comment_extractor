require 'spec_helper'

class StripComment::Scanner
  describe Haml do
    subject { Haml }
    it { pending 'Implementation scanner' }
    its(:disabled?) { should be_true }
  end
end
