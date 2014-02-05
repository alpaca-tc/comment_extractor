require 'spec_helper'

describe StripComment::CodeObject do
  describe '.new' do
    subject { StripComment::CodeObject.new }

    it 'returns instance' do
      expect(subject.file).to eql nil
      expect(subject.value).to eql nil
      expect(subject.metadata).to eql({})
    end
  end
end
