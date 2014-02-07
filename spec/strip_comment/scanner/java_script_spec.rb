require 'spec_helper'

describe StripComment::Scanner::JavaScript do
  let(:scanner) { StripComment::Scanner::JavaScript.new(dummy_file_object, content) }
  let(:dummy_file_object) { StripComment::FileObject.new(__FILE__) }

  describe '#scan' do
    let(:scan) { scanner.scan }
    let(:comment) { "This is comment line" }
    let(:dummy_program) { 'function() {}' }

    shared_examples_for 'a scanning' do
      it { expect(scan).to be_an_instance_of(Array) }

      it 'works' do
        expected.each_with_index do |value, index|
          expect(scan[index].value).to eql value
        end
      end
    end

    context 'given single line comment(`// ...`)' do
      let(:content) { "// #{comment}" }
      let(:expected) { [comment.strip] }
      it_should_behave_like 'a scanning'
    end

    context 'given single line comment(`/*...*/`)' do
      let(:content) { "#{dummy_program}/*#{comment}*/" }
      let(:expected) { [comment.strip] }
      it_should_behave_like 'a scanning'
    end

    context 'given multi line comment(`/**...\n * ...\n */`)' do
      let(:content) { "#{dummy_program}/**\n * #{comment}\n#{comment}\n */" }
      let(:expected) { ['', comment.strip, comment.strip] }
      it_should_behave_like 'a scanning'
    end
  end
end
