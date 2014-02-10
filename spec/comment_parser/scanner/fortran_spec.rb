require 'spec_helper'

class CommentParser::Scanner
  describe Fortran do
    let(:klass) { Fortran }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
