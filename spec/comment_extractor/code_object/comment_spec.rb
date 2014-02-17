require 'spec_helper'
require 'comment_extractor/code_object/comment'

module CommentExtractor
  describe CodeObject::Comment do
    describe '.new' do
      subject { described_class.new(line: line) }
      let(:line) { 21 }

      it "returns a instance of #{described_class}" do
        expect(subject.line).to eql(line)
      end
    end
  end
end
