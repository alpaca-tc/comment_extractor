require 'spec_helper'

class CommentParser::Scanner
  describe Shell do
    let(:klass) { Shell }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end