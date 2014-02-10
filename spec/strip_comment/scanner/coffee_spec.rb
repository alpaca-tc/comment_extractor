require 'spec_helper'

class StripComment::Scanner
  describe Coffee do
    let(:klass) { Coffee }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
