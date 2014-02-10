require 'spec_helper'

class CommentParser::Scanner
  describe Clojure do
    let(:klass) { Clojure }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
