require 'spec_helper'
require 'comment_extractor/extractor'

module CommentExtractor
  describe Extractor do
    let(:content) { File.read(__FILE__) }
    let(:scanner_object) { Extractor.new(content) }

    describe 'InstanceMethods' do
      describe '#new' do
        subject { scanner_object }
        it { expect { subject }.to_not raise_error }

        it 'initializes attributes' do
          expect(subject.content).to eql content
        end
      end

      describe '#scanner' do
        subject { scanner_object.send(:scanner) }
        it { should be_an_instance_of(StringScanner) }
      end

      describe '#content' do
        subject { scanner_object.content }
        it { should be_an_instance_of String }
      end

      describe '#extract_comments' do
        subject { scanner_object.extract_comments }
        it { expect { subject }.to raise_error(NotImplementedError) }
      end

      describe '#add_comment' do
        before do
          line = 0
          value = 1
          scanner_object.send(:add_comment, line, value, {})
        end

        subject { scanner_object.comments[0] }

        it 'adds new comment object to @comments' do
          expect(subject).to be_an_instance_of(CodeObject::Comment)
        end
      end

    end

    describe 'ClassMethods' do
      let(:scanner_klass) { Extractor }

      describe '.disable!' do
        it 'disables own status' do
          expect(scanner_klass.disabled?).to be_falsy
          scanner_klass.disable!
          expect(scanner_klass.disabled?).to be_truthy
        end
      end

      describe 'definition' do
        after do
          scanner_klass.send(:remove_instance_variable, :@definition)
        end

        shared_examples_for 'a setting definition' do
          before do
            scanner_klass.send(key, value)
          end

          it 'defines definitions for own' do
            expect(scanner_klass.definition).to eql({ key => value })
          end
        end

        describe '.shebang' do
          let(:value) { %r!#\! path/to/test! }
          let(:key) { :shebang }
          it_should_behave_like 'a setting definition'
        end

        describe '.filetype' do
          let(:value) { 'ruby' }
          let(:key) { :filetype }
          it_should_behave_like 'a setting definition'
        end

        describe '.filename' do
          let(:value) { /\.rb$/ }
          let(:key) { :filename }
          it_should_behave_like 'a setting definition'
        end
      end
    end
  end
end
