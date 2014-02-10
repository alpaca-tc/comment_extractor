require 'spec_helper'

class CommentParser::Scanner
  describe Vim do
    let(:klass) { Vim }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
