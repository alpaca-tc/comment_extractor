require 'spec_helper'

describe StripComment::Scanner::Ruby do
  let(:scanner) { StripComment::Scanner::Ruby.new(source) }

  describe '#scan' do
    let(:scan) { scanner.scan }
    let(:comment) { "# This is comment line" }
    let(:dummy_program) { 'def initlaize; end' }

    shared_examples_for 'a scanning' do
      it 'works' do
        expect(scan).to eql expected
      end
    end

    context 'given single line comment(`#`)' do
      let(:source) { "#{comment}" }
      let(:expected) { [comment] }
      it_should_behave_like 'a scanning'
    end

    context 'given postposition single line comment(`code ... #`)' do
      let(:source) { "#{dummy_program} #{comment}" }
      let(:expected) { [comment] }
      it_should_behave_like 'a scanning'
    end

    context 'given multi line comment(`#...\n#...`)' do
      let(:source) { "#{dummy_program}\n#{comment}\n#{comment}" }
      let(:expected) { [comment, comment] }
      it_should_behave_like 'a scanning'
    end

    context 'given multi line comment(`#...\n#...`)' do
      let(:source) { "#{dummy_program}\n#{comment}\n#{comment}" }
      let(:expected) { [comment, comment] }
      it_should_behave_like 'a scanning'
    end

    context 'given multi line comment(`=begin...\n=end`)' do
      let(:source) { "#{dummy_program}\n=begin\n#{comment}\n=end" }
      let(:expected) { [comment] }
      it_should_behave_like 'a scanning'
    end
  end
end
