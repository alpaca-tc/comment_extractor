require 'spec_helper'

class StripComment::Scanner
  describe Sql do
    subject { Sql }
    it { pending 'Implementation scanner' }
    its(:disabled?) { should be_true }
  end
end
