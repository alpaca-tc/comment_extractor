require 'spec_helper'

class CommentParser::Scanner
  describe Haskell do
    let(:klass) { Haskell }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
