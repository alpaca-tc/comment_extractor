require 'spec_helper'
require 'comment_extractor/code_object'
require 'comment_extractor/code_objects'

module CommentExtractor
  describe CodeObjects do
    describe 'ClassMethods' do
      describe '.new' do
        subject { described_class.new(file: file_path) }
        let(:file_path) { 'path/to/file' }

        it 'returns a instance of CodeObjects' do
          expect(subject).to be_an_instance_of CodeObjects
          expect(subject.file).to eql file_path
        end
      end
    end

    describe 'InstanceMethods' do
      let(:code_objects) { described_class.new(file: 'path/to/file') }

      describe '#<<' do
        subject { code_objects << code_object }

        context 'given a not instance of CodeObject::Comment' do
          let(:code_object) { nil }
          it { expect { subject }.to raise_error(TypeError) }
        end

        context 'given instance of CodeObject::Comment' do
          let(:code_object) { CodeObject.new(value: 3) }

          it 'adds a information of self to argument' do
            subject
            expect(code_object.metadata[:parent]).to eql code_objects
          end

          it 'adds code_object' do
            expect { subject }.to change { code_objects.size }.to(1).from(0)
          end
        end
      end
    end
  end
end
