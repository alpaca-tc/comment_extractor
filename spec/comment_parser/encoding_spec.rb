require 'spec_helper'

module CommentParser
  describe Encoding do
    let(:hello_world) { 'hello_world' }
    let(:temp) { Tempfile.new('tempfile') }

    describe '.encode' do
      subject { Encoding.encode(*[body, format].compact) }

      shared_examples_for 'a encoding' do
        let(:format_type) { respond_to?(:format_expected) ? format_expected : format }
        let(:body_text) { respond_to?(:body_expected) ? body_expected : body }

        it 'works' do
          should eql body_text
          expect(subject.encoding).to eql format_type
        end
      end

      context 'given raw text' do
        let(:body) { hello_world }

        context 'and nil as encoding type' do
          let(:format) { nil }
          let(:format_expected) { ::Encoding::UTF_8 }

          it_should_behave_like 'a encoding'
        end

        context 'and UTF-8 as encoding type' do
          let(:format) { ::Encoding::UTF_8 }

          it_should_behave_like 'a encoding'
        end
      end

      context 'given invalid text' do
        let(:x_mark) { "\u00D7" }
        let(:body) { x_mark }
        let(:format) { ::Encoding::US_ASCII }

        it { expect { subject }.to raise_error(::Encoding::UndefinedConversionError) }
      end
    end

    describe '.read_file' do
      subject { Encoding.read_file(temp.path) }

      before do
        temp.write(hello_world)
        temp.flush
      end

      it 'read file which is encoded' do
        expect(Encoding).to receive(:encode)
          .at_least(:once)
          .with(hello_world)
          .and_return(hello_world)
        expect(subject).to eql hello_world
      end
    end
  end
end
