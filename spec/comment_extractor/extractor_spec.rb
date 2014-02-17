require 'spec_helper'
require 'comment_extractor/extractor'

module CommentExtractor
  describe Extractor do
    let(:content) { File.read(__FILE__) }
    let(:scanner_object) { Extractor.new(content) }

    describe 'ClassMethods' do
      let(:scanner_klass) { Extractor }

      describe '.new' do
        subject { scanner_object }
        it { expect { subject }.to_not raise_error }

        it 'initializes attributes' do
          expect(subject.content).to eql content
          expect(subject.code_objects).to be_an_instance_of CodeObjects
        end
      end

      describe '.disable!' do
        it 'disables own status' do
          expect(scanner_klass.disabled?).to be_falsy
          scanner_klass.disable!
          expect(scanner_klass.disabled?).to be_truthy
        end
      end

      describe 'schema' do
        after do
          scanner_klass.send(:remove_instance_variable, :@schema)
        end

        shared_examples_for 'a setting schema' do
          before do
            scanner_klass.send(key, value)
          end

          it 'defines schemas for own' do
            expect(scanner_klass.schema).to eql({ key => value })
          end
        end

        describe '.shebang' do
          let(:value) { %r!#\! path/to/test! }
          let(:key) { :shebang }
          it_should_behave_like 'a setting schema'
        end

        describe '.filetype' do
          let(:value) { 'ruby' }
          let(:key) { :filetype }
          it_should_behave_like 'a setting schema'
        end

        describe '.filename' do
          let(:value) { /\.rb$/ }
          let(:key) { :filename }
          it_should_behave_like 'a setting schema'
        end
      end
    end

    describe 'PublicInstanceMethods' do
      describe '#extract_comments' do
        subject { scanner_object.extract_comments }
        it { expect { subject }.to raise_error(NotImplementedError) }
      end
    end

    describe 'ProtectedInstanceMethods' do
      describe '#scan' do
        subject { scanner_object.send(:scan) }
        it { expect { subject }.to raise_error(NotImplementedError) }
      end

      describe '#scanner' do
        subject { scanner_object.send(:scanner) }
        it { should be_an_instance_of(StringScanner) }
      end

      describe '#build_comment' do
        subject { scanner_object.send(:build_comment, 1, 'comment') }
        it { expect(subject).to be_an_instance_of CodeObject::Comment }
      end

      describe '#content' do
        subject { scanner_object.content }
        it { should be_an_instance_of String }
      end
    end

    describe 'PrivateInstanceMethods' do
      describe '#raise_report' do
        subject { scanner_object.send(:raise_report) }

        it { expect { subject }.to raise_error(Extractor::SyntaxDefinitionError) }
      end
    end
  end
end
