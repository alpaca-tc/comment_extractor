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

      shared_context 'appending code_object to self' do
        context 'given not a instance of CodeObject::Comment' do
          let(:code_object) { nil }
          it { expect { subject }.to raise_error(TypeError) }
        end

        context 'given instance of CodeObject::Comment' do
          it 'adds a information of self to argument' do
            subject
            expect(code_object.metadata[:parent]).to equal described_instance
          end

          it 'adds code_object' do
            expect { subject }.to change { described_instance.size }.to(1).from(0)
          end
        end
      end

      describe '#<<' do
        subject { described_instance << code_object }
        it_behaves_like 'appending code_object to self'
      end

      describe '#push' do
        subject { described_instance.push code_object, code_object }
        it_behaves_like 'appending code_object to self'
      end

      describe '#concat' do
        subject { described_instance.concat [code_object] }
        it_behaves_like 'appending code_object to self'
      end
    end
  end
end
