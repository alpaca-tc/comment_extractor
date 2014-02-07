require 'spec_helper'

class StripComment::Scanner
  describe Perl do
    subject { Perl }
    it { pending 'Implementation scanner' }
    its(:disabled?) { should be_true }
  end
end
