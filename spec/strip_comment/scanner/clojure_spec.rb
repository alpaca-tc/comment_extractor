require 'spec_helper'

class StripComment::Scanner
  describe Clojure do
    subject { Clojure }
    it { pending 'Implementation scanner' }
    its(:disabled?) { should be_true }
  end
end
