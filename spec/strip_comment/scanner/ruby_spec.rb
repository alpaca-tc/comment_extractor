require 'spec_helper'

describe StripComment::Scanner::Ruby do
  let(:scanner) { StripComment::Scanner::Ruby.new(dummy_file_object, content) }
  let(:dummy_file_object) { StripComment::FileObject.new(__FILE__) }

  describe '#scan' do
    let(:scan) { scanner.scan }
    let(:comment) { "# This is comment line" }
    let(:dummy_program) { 'def initlaize; end' }

    shared_examples_for 'a scanning' do
      it { expect(scan).to be_an_instance_of(Array) }

      it 'works' do
        result = scan
        expected.each_with_index do |value, index|
          expect(result[index].value).to eql value
        end
      end
    end

    context 'given single line comment(`#`)' do
      let(:content) { comment }
      let(:expected) { [comment.strip] }
      it_should_behave_like 'a scanning'
    end

    context 'given postposition single line comment(`code ... #`)' do
      let(:content) { "#{dummy_program} #{comment}" }
      let(:expected) { [comment.strip] }
      it_should_behave_like 'a scanning'
    end

    context 'given multi line comment(`#...\n#...`)' do
      let(:content) { "#{dummy_program}\n#{comment}\n#{comment}" }
      let(:expected) { [comment.strip, comment.strip] }
      it_should_behave_like 'a scanning'
    end

    context 'given multi line comment(`#...\n#...`)' do
      let(:content) { "#{dummy_program}\n#{comment}\n#{comment}" }
      let(:expected) { [comment.strip, comment.strip] }
      it_should_behave_like 'a scanning'
    end

    context 'given multi line comment(`=begin...\n=end`)' do
      let(:content) { "#{dummy_program}\n=begin\n#{comment}\n=end" }
      let(:expected) { ["#{comment}\n"] }
      it_should_behave_like 'a scanning'
    end
  end
end
