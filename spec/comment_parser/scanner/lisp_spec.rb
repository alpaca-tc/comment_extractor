require 'spec_helper'

class CommentParser::Scanner
  describe Lisp do
    let(:klass) { Lisp }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
