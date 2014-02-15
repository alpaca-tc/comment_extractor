require 'spec_helper'
require 'comment_extractor/smart_string_scanner'

using CommentExtractor::SmartStringScanner

module CommentExtractor
  describe SmartStringScanner do

    let(:scanner) { StringScanner.new("...\n...") }

    describe 'refines #current_line' do
      context 'when scanner has already used' do
        it 'returns current line number' do
          expect(scanner.current_line).to eql 1

          scanner.scan(/^.*$/) # Scanning one line
          expect(scanner.current_line).to eql 1

          scanner.scan(/\n/) # Go to next line
          expect(scanner.current_line).to eql 2
        end
      end
    end
  end
end
