require 'spec_helper'
require 'comment_extractor/parser'

using CommentExtractor::DetectableSchemeFile

module CommentExtractor
  describe Parser do
    describe 'InstanceMethods' do
      # [todo] - Fix
      describe '#parse' do
        let(:expected) { [] }
        before do
          @scanner = double
          expect(@scanner).to receive(:scan).once
          expect(@scanner).to receive(:comments).once.and_return(expected)
        end

        it 'parses file and returns comments' do
          parser = Parser.new(@scanner)
          expect(parser.parse).to be_an_instance_of Array
        end
      end
    end

    describe 'ClassMethods' do
      let(:scanner_definitions) do
        {
          { filename: /\.rb$/, filetype: 'ruby', shebang: /.*ruby$/, } => 'Ruby',
          { filename: /\.js$/, shebang: /.*(js|node)$/, } => 'JavaScript',
        }
      end

      describe '.new' do
        subject { Parser.new(scanner).instance_variable_get(:@scanner) }
        let(:scanner) { :scanner }
        it { expect { subject }.to_not raise_error }
      end
    end
  end
end
