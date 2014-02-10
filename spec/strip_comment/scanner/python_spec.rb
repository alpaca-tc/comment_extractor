require 'spec_helper'

class CommentParser::Scanner
  describe Python do
    let(:klass) { Python }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
