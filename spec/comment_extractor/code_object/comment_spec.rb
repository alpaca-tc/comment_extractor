require 'spec_helper'

module CommentExtractor
  describe CodeObject::Comment do
    describe '.new' do
      subject { CodeObject::Comment.new }

      it 'returns instance' do
        expect(subject.line).to eql(nil)
      end
    end
  end
end
