require 'spec_helper'

class CommentParser::Scanner
  describe Html do
    let(:klass) { Html }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
