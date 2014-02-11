require 'spec_helper'

module CommentParser
  describe Scanner do
    let(:file_path) { __FILE__ }
    let(:file_object) { FileObject.new(file_path) }
    let(:content) { file_object.content }
    let(:scanner_object) { Scanner.new(file_object, content) }

    describe 'InstanceMethods' do
      describe '#new' do
        subject { scanner_object }
        it { expect { subject }.to_not raise_error }

        it 'initializes attributes' do
          expect(subject.file_object).to eql file_object
          expect(subject.content).to eql content
          expect(subject.instance_variable_get(:@comments)).to eql []
        end
      end

      describe '#scanner' do
        it { expect(scanner_object.build_scanner).to be_an_instance_of(StringScanner) }
      end

      describe '#content' do
        it { pending 'writes test' }
      end

      describe '#scan' do
        it { expect { scanner_object.scan }.to raise_error('Neet to implement') }
      end

      describe '#add_comment' do
        before do
          line = 0
          value = 1
          scanner_object.add_comment(line, value)
        end

        it 'adds new comment object to @comments' do
          comment_klass = CodeObject::Comment
          expect(scanner_object.comments[0]).to be_an_instance_of(comment_klass)
        end
      end

      describe '#current_line' do
        context 'when scanner has not built yet' do
          it { expect(scanner_object.current_line).to be_nil }
        end

        context 'when scanner has already used' do
          before do
            scanner = scanner_object.build_scanner
            scanner.scan(/^.*$/) # Scanning one line
          end

          context 'when shebang is not detected' do
            it { expect(scanner_object.current_line).to eql 2 }
          end

          context 'when shebang is detected' do
            before do
              allow(scanner_object).to receive(:shebang) { '' }
            end

            it { expect(scanner_object.current_line).to eql 3 }
          end
        end
      end
    end

    describe 'ClassMethods' do
      let(:scanner_klass) { Scanner }

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
