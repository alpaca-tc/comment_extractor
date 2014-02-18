require 'spec_helper'
require 'comment_extractor/string_scanner'

module CommentExtractor
  describe StringScanner do
    let(:scanner) { StringScanner.new("...\n...") }

    describe '#current_line' do
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
