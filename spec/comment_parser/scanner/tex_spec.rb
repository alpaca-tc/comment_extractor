require 'spec_helper'

class CommentParser::Scanner
  describe Tex do
    let(:klass) { Tex }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
