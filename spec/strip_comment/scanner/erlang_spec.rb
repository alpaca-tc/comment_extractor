require 'spec_helper'

class StripComment::Scanner
  describe Erlang do
    let(:klass) { Erlang }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
