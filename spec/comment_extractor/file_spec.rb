require 'spec_helper'
require 'comment_extractor/file'

module CommentExtractor
  describe File do
    let(:asset_dir) { File.expand_path('../../assets', __FILE__) }
    let(:file) { File.new(file_path) }

    let(:binary_path) { "#{asset_dir}/binary_file" }
    let(:shebang_path) { "#{asset_dir}/shebang_file" }
    let(:ruby_path) { __FILE__ }

    describe '#binary?' do
      subject { file.binary? }

      context 'given the binary file' do
        let(:file_path) { binary_path }
        it { should be_truthy }
      end

      context 'given the source file' do
        let(:file_path) { ruby_path }
        it { should be_falsy }
      end
    end

    describe '#shebang' do
      subject { file.shebang }

      context 'given the source file' do
        let(:file_path) { __FILE__ }
        it { should be_nil }
      end

      context 'given ruby file' do
        let(:file_path) { shebang_path }
        it { should match %r!/ruby$! }
      end
    end

    describe '#content' do
      subject { file.content }

      context 'given a binary_file' do
        let(:file_path) { binary_path }
      end

      context 'given ruby file' do
        let(:file_path) { ruby_path }

        it 'equals the result of File.read' do
          should eql File.read(file_path)
        end

        context 'contains shebang' do
          let(:file_path) { shebang_path }

          it 'equals the result without shebang' do
            should eql "1\n2\n"
          end
        end
      end
    end
  end
end
