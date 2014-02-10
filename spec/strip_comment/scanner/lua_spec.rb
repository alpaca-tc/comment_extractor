require 'spec_helper'

class StripComment::Scanner
  describe Sql do
    let(:klass) { Sql }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
