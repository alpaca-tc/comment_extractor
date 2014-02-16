require 'spec_helper'
require 'comment_extractor/extractor_manager'

module CommentExtractor
  describe ExtractorManager do
    describe 'ClassMethods' do
      describe '.regist_extractor' do
        before do
          described_class.regist_extractor(extractor)
        end

        let(:extractor) { Object }
        subject { described_class.class_variable_get(:@@extractors) }

        it 'registers a extractor to self' do
          expect(subject[:Object]).to be_nil
        end
      end

      describe '.default_extractors' do
        subject { described_class.default_extractors }

        it 'returns Array contains default extractors' do
          expect(subject).to be_an_instance_of Array
        end
      end

      # describe '.find_scanner_by_shebang' do
      #   subject { Parser.find_scanner_by_shebang(shebang) }
      #
      #   context 'given a shebang' do
      #     let(:shebang) { '#! /usr/bin/node' }
      #     it 'finds ExtractorKlass by shebang' do
      #       should eql 'JavaScript'
      #     end
      #   end
      #
      #   context 'given empty string' do
      #     let(:shebang) { '' }
      #     it { should be_nil }
      #   end
      # end
      #
      # describe '.find_scanner_by_filename' do
      #   subject { Parser.find_scanner_by_filename(filename) }
      #
      #   context 'given a name registered' do
      #     let(:filename) { 'rubyfile.rb' }
      #
      #     it 'returns ExtractorKlass' do
      #       should eql 'Ruby'
      #     end
      #   end
      #
      #   context 'given a name not registered' do
      #     let(:filename) { 'no name' }
      #     it { should be_nil }
      #   end
      # end
      #
      # describe '.find_scanner_by_filetype' do
      #   subject { Parser.find_scanner_by_filetype(filetype) }
      #
      #   context 'given a filetype registered' do
      #     let(:filetype) { 'ruby' }
      #
      #     it 'returns ExtractorKlass' do
      #       should eql 'Ruby'
      #     end
      #   end
      #
      #   context 'given a filetype not registered' do
      #     let(:filetype) { 'no name' }
      #
      #     it 'returns ExtractorKlass' do
      #       should be_nil
      #     end
      #   end
      # end
      #
      # describe '.can_parse' do
      #   subject { Parser.can_parse(file) }
      #
      #   let(:binary?) { false }
      #   let(:content) { '' }
      #   let(:path) { '/path/to/file' }
      #   let(:shebang) { nil }
      #   let(:file) do
      #     double(File).tap do |f|
      #       allow(f).to receive(:shebang) { shebang }
      #       allow(f).to receive(:content) { content }
      #       allow(f).to receive(:binary?) { binary? }
      #       allow(f).to receive(:path) { path }
      #     end
      #   end
      #
      #   context 'given a file which has a file extension' do
      #     let(:path) { '/path/to/ruby.rb' }
      #     it 'finds ExtractorKlass by file name' do
      #       should eql 'Ruby'
      #     end
      #   end
      #
      #   context 'given binary file' do
      #     let(:binary?) { true }
      #     it { should be_nil }
      #   end
      #
      #   context 'given a file which contains shebang' do
      #     let(:shebang) { '/usr/bin/node' }
      #
      #     it 'finds ExtractorKlass by shebang' do
      #       should eql 'JavaScript'
      #     end
      #   end
      # end
      #
      # describe '.for' do
      #   let(:file) do
      #     File.new(__FILE__)
      #   end
      #   subject { Parser.for(file) }
      #
      #   before do
      #     allow(Parser).to receive(:can_parse).with(file).and_return(scanner)
      #   end
      #
      #   context 'when scanner is found' do
      #     let(:scanner) do
      #       double.tap do |s|
      #         allow(s).to receive(:new).with(file).and_return(nil)
      #       end
      #     end
      #
      #     it 'initializes Extractor' do
      #       expect(subject).to be_an_instance_of described_class
      #     end
      #   end
      #
      #   context 'when scanner is not found' do
      #     let(:scanner) { nil }
      #     it { should be_nil }
      #   end
      # end
    end
  end
end
