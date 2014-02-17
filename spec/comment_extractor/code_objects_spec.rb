require 'spec_helper'
require 'comment_extractor/code_object'
require 'comment_extractor/code_objects'

module CommentExtractor
  describe CodeObjects do
    let(:file_path) { 'path/to/file' }

    describe 'ClassMethods' do
      describe '.new' do
        subject { described_class.new(file: file_path) }

        it 'initializes a instance of CodeObjects' do
          expect(subject).to be_an_instance_of CodeObjects
          expect(subject.file).to eql file_path
        end
      end
    end

    describe 'InstanceMethods' do
      let(:described_instance) { described_class.new(file: file_path) }
      let(:code_object) { CodeObject.new(value: 3) }
      let(:code_object_size) { 1 }

      shared_context "a extended array's method" do
        context 'given a instance of CodeObject::Comment' do
          it 'adds a information of self to argument' do
            subject
            expect(code_object.metadata[:parent]).to equal described_instance
          end

          it 'adds a code_object' do
            expect { subject }.to change { described_instance.size }
              .to(code_object_size).from(0)
            expect(subject.all? { |v| v.is_a?(code_object.class) }).to be_truthy
          end
        end

        context 'not given a instance of CodeObject::Comment' do
          let(:code_object) { nil }
          it { expect { subject }.to raise_error(TypeError) }
        end
      end

      describe '#<<' do
        subject { described_instance << code_object }

        it_behaves_like "a extended array's method"
      end

      describe '#push' do
        subject { described_instance.push code_object, code_object }
        let(:code_object_size) { 2 }

        it_behaves_like "a extended array's method"
      end

      describe '#concat' do
        subject { described_instance.concat [code_object], [code_object] }
        let(:code_object_size) { 2 }

        it_behaves_like "a extended array's method"
      end
    end
  end
end
