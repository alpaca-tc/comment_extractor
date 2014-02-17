require 'spec_helper'
require 'comment_extractor/code_object'

module CommentExtractor
  describe CodeObject do
    describe 'ClassMethods' do
      describe '.new' do
        subject { described_class.new(value: value, other: :other) }
        let(:value) { 'value' }

        it "returns a instance of #{described_class}" do
          expect(subject.value).to eql value
          expect(subject.metadata).to eql({ other: :other })
        end
      end
    end
  end
end
