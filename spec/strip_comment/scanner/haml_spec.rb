require 'spec_helper'

class CommentParser::Scanner
  describe Haml do
    let(:klass) { Haml }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
