require 'spec_helper'

class CommentParser::Scanner
  describe Perl do
    let(:klass) { Perl }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
