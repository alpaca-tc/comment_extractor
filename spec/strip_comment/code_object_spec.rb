require 'spec_helper'

module StripComment
  describe CodeObject do
    describe '.new' do
      subject { CodeObject.new }

      it 'returns instance' do
        expect(subject.file).to eql nil
        expect(subject.value).to eql nil
        expect(subject.metadata).to eql({})
      end
    end
  end
end
