require 'spec_helper'
require 'comment_extractor/code_object'

module CommentExtractor
  describe CodeObject::Comment do
    describe '.new' do
      subject { CodeObject::Comment.new(line: line) }
      let(:line) { 21 }

      it 'returns instance' do
        expect(subject.line).to eql(line)
      end
    end
  end
end
