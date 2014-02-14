RSpec.configure do |config|
  config.add_setting :source_code_path, default: 'spec/assets/source_code'
end

module RSpec::CommentExtractor::ScannerExampleGroup
  include RSpec::CommentExtractor::Matchers::DetectComment

  module ClassMethods
    def disable_test_for_scanner!
      @test_for_scanner_disabled = true
    end
  end
  attr_reader :test_for_scanner

  def build_scanner(file, content = nil)
    described_class.new(file, content)
  end

  def source_code_path(file_name = nil)
    dir = RSpec.configuration.source_code_path
    file_name ? "#{dir}/#{file_name}" : dir
  end

  def default_file_name
    described_class.to_s[/[^:]+$/].gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end

  def self.included(k)
    k.class_eval do
      extend ClassMethods
      metadata[:type] = :scanner

      # Skips test when scanner has already disabled
      if metadata[:disabled] == true
        shared_examples_for 'disabled' do
          subject { described_class.disabled? }
          it { expect(subject).to be_truthy }
        end

        it_behaves_like 'disabled'

        pending 'skipping test for scanner'

        next
      end

      subject { scanner }

      let(:file_path) { default_file_name }
      let(:source_code) { CommentExtractor::File.new(source_code_path(file_path)) }
      let(:scanner) { build_scanner(source_code) }

      context '.new' do
        it { expect { build_scanner(source_code) }.to_not raise_error }
      end

      shared_examples_for 'scanning source code' do |file_name|
        context '.scan' do
          let(:comments) do
            source_code.content.split("\n").each_with_object({}) do |line, memo|
              if %r!(?<comment>\[-(?<line_number>\d+)-\].*)$! =~ line
                comment.sub!(/(?<=\[-end-\]).*$/, '') if comment =~ /\[-end-\]/
                memo[line_number.to_i] = comment
              end
            end
          end

          before do
            scanner.scan
          end

          it 'scans source_code' do
            expect { scanner.comments }.to detect_comment(comments)
          end
        end
      end

      shared_examples_for 'detecting shebang' do |*shebangs|
        # let dummy source code
        let(:source_code) { CommentExtractor::File.new(__FILE__) }

        shebangs.each do |shebang|
          it 'detects shebang' do
            expect(shebang).to match scanner.shebang
          end
        end
      end
    end
  end
end
