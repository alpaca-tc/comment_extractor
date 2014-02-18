require 'spec_helper'
require 'comment_extractor/file'
require 'tempfile'

module CommentExtractor
  describe File do
    let(:file) { File.new(file_path) }
    let(:asset_dir) { File.expand_path('../../assets', __FILE__) }
    let(:binary_path) { "#{asset_dir}/binary_file" }

    describe 'ClassMethods' do
      describe '.shebang' do
        subject { File.shebang(file.path) }
        let(:file_path) do
          Tempfile.new('tempfile').tap do |f|
            f.write(content)
            f.flush
            f.path
          end
        end
        let(:content) { '' }

        before do
          allow(File).to receive(:extname).and_return(extname)
        end

        context 'when initialized file with a extension' do
          let(:extname) { '.rb' }
          it { should be_nil }
        end

        context 'when initialized file with no extension' do
          let(:extname) { '' }

          context 'content has no shebang' do
            it 'does not detect shebang' do
              should be_nil
            end
          end

          context 'content has a shebang' do
            let(:content) { "#! /usr/local/bin/ruby\n" }

            it 'detects shebang' do
              should eql '/usr/local/bin/ruby'
            end
          end
        end
      end

      describe '.binary?' do
        subject { File.binary?(file_path) }

        context 'given the binary file' do
          let(:file_path) { binary_path }
          it { should be_truthy }
        end

        context 'given the source file' do
          let(:file_path) { __FILE__ }
          it { should be_falsy }
        end
      end
    end

    describe '#read_content' do
      subject { file.read_content }

      context 'given a binary_file' do
        let(:file_path) { binary_path }
        it { should be_nil }
      end

      context 'given a source code file' do
        let(:file_path) { __FILE__ }

        it "returns file's content" do
          should eql File.read(file_path)
        end

        context 'contains shebang' do
          let(:body) { 'HelloWorld' }
          let(:file_path) do
            Tempfile.new('tempfile').tap do |f|
              f.write("#! /usr/local/shebang\n#{body}")
              f.flush
              f.path
            end
          end

          it 'equals the result without shebang' do
            should eql body
          end
        end
      end
    end
  end
end
