require 'spec_helper'

class CommentParser::Scanner
  describe Sql do
    let(:klass) { Sql }
    it { pending 'scanner' }

    describe '#disabled?' do
      subject { klass.disabled? }
      it { should be_truthy }
    end
  end
end
