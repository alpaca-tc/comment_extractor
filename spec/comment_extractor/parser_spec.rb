require 'spec_helper'
require 'comment_extractor/parser'

using CommentExtractor::DetectableSchemeFile

module CommentExtractor
  describe Parser do
    let(:expected_comments) { [] }
    let(:stub_extractor) do
      Class.new(CommentExtractor::Extractor).tap do |extractor|
        allow(extractor).to receive(:extract_comments).and_return(expected_comments)
      end
    end

    describe 'InstanceMethods' do
      let(:parser) { described_class.new(stub_extractor) }

      describe '#extract_comments' do
        subject { parser.extract_comments }

        before do
          expect(stub_extractor).to receive(:extract_comments).once
        end

        it 'parses file and returns comments' do
          expect(subject).to be_an_instance_of Array
        end
      end
    end

    describe 'ClassMethods' do
      describe '.for' do
        subject { described_class.for(file_path) }
        let(:file_path) { __FILE__ }

        before do
          allow(ExtractorManager).to receive(:can_extract)
            .and_return(stub_extractor)
        end

        it 'finds extractor and initializes one' do
          expect(subject).to be_an_instance_of described_class
          extractor = subject.extractor
          expect(extractor).to be_a Extractor
          expect(extractor.code_objects.file).to eql file_path
        end
      end

      describe '.new' do
        subject { described_class.new(stub_extractor) }

        it 'initializes a instance of Parser' do
          expect { subject }.to_not raise_error
        end
      end
    end
  end
end
