require 'spec_helper'

describe StripComment::CodeObject::Comment do
  describe '.new' do
    subject { StripComment::CodeObject::Comment.new }

    it 'returns instance' do
      expect(subject.line).to eql(nil)
    end
  end
end
