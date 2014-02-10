require 'spec_helper'

class CommentParser::Scanner
  describe Sqf do
    let(:klass) { Sqf }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
