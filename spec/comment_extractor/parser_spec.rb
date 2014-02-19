require 'spec_helper'
require 'comment_extractor/parser'

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

        context 'when initialized by a correct type Extractor' do
          before do
            expect(stub_extractor).to receive(:extract_comments).once
          end

          it 'parses file and returns comments' do
            expect(subject).to be_an_instance_of Array
          end
        end

        context 'when initialized by not instance of Extractor' do
          let(:parser) { described_class.new(nil) }
          it { expect { subject }.to raise_error(TypeError) }
        end
      end
    end

    describe 'ClassMethods' do
      describe '.for' do
        subject { described_class.for(file_path) }
        let(:file_path) { __FILE__ }

        context 'when extractor is found' do
          before do
            allow(Extractors).to receive(:can_extract).
              and_return(stub_extractor)
          end

          it 'initializes extractor' do
            expect(subject).to be_an_instance_of described_class
            extractor = subject.extractor
            expect(extractor).to be_a Extractor
            expect(extractor.code_objects.file).to eql file_path
          end
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
