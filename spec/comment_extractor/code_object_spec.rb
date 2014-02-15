require 'spec_helper'
require 'comment_extractor/code_object'

module CommentExtractor
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
