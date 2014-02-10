require 'spec_helper'

class CommentParser::Scanner
  describe Php do
    let(:klass) { Php }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
