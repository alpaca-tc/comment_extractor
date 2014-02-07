require 'spec_helper'

class StripComment::Scanner
  describe Fortran do
    subject { Fortran }
    it { pending 'Implementation scanner' }
    its(:disabled?) { should be_true }
  end
end
