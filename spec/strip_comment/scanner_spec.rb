require 'spec_helper'

module StripComment
  describe Scanner do
    let(:file_object) { FileObject.new(file_path) }
    let(:file_path) { __FILE__ }

    subject { Scanner.new(file_object, file_object.content) }

    it { expect { subject }.to_not raise_error }
    it { expect { subject.scan }.to raise_error('Neet to implement') }

    describe 'ClassMethods' do
      subject { Scanner }

      describe 'definition' do
        after do
          subject.send(:remove_instance_variable, :@definition)
        end

        shared_examples_for 'a setting definition' do
          before do
            Scanner.send(key, value)
          end

          it 'defines definitions for own' do
            expect(Scanner.definition).to eql({ key => value })
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
