require 'spec_helper'
require 'comment_extractor/encoding'
require 'tempfile'

module CommentExtractor
  describe Encoding do
    describe 'ClassMethods' do
      let(:body) { 'hello_world' }
      let(:temp) { Tempfile.new('tempfile') }

      describe '.encode' do
        subject { described_class.encode(*[body, format].compact) }

        shared_examples_for 'a text encoder' do
          let(:expected_format_type) do
            respond_to?(:format_expected) ? format_expected : format
          end
          let(:expected_body) do
            respond_to?(:body_expected) ? body_expected : body
          end

          it 'works' do
            expect(subject).to eql expected_body
            expect(subject.encoding).to eql expected_format_type
          end
        end

        context 'given a raw text' do
          context 'and empty as encoding type' do
            let(:format) { nil }
            let(:format_expected) { ::Encoding::UTF_8 }

            it_behaves_like 'a text encoder'
          end

          context 'and UTF-8 as encoding type' do
            let(:format) { ::Encoding::UTF_8 }

            it_behaves_like 'a text encoder'
          end
        end

        context 'given a invalid text' do
          let(:body) { "\u00D7"  }
          let(:format) { ::Encoding::US_ASCII }
          let(:expected_error) { ::Encoding::UndefinedConversionError }

          it { expect { subject }.to raise_error(expected_error) }
        end
      end

      describe '.read_file' do
        subject { Encoding.read_file(temp.path) }

        before do
          temp.write(body)
          temp.flush
        end

        context 'given a file_path' do
          it 'returns a encoded content' do
            expect(described_class).to receive(:encode)
            .at_least(:once)
            .with(body) { |v| v }
            expect(subject).to eql body
          end
        end
      end
    end
  end
end
