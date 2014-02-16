RSpec.configure do |config|
  config.add_setting :source_code_path, default: 'spec/assets/source_code'
end

module RSpec::CommentExtractor::ExtractorExampleGroup
  include RSpec::CommentExtractor::Matchers::ExtractComment

  def build_scanner(content = nil)
    described_class.new(content)
  end

  def source_code_path(file_name = nil)
    dir = RSpec.configuration.source_code_path
    file_name ? "#{dir}/#{file_name}" : dir
  end

  def self.included(k)
    k.class_eval do
      metadata[:type] = :scanner

      # Skips test when scanner has already disabled
      if metadata[:disabled] == true
        shared_examples_for 'disabled' do
          subject { described_class.disabled? }
          it { expect(subject).to be_truthy }
        end

        it_behaves_like 'disabled'

        pending 'skipping a test'

        next
      end

      let(:content) { '' }
      let(:scanner) { build_scanner(content) }

      context '.new' do
        it { expect { scanner }.to_not raise_error }
      end

      shared_examples_for 'extracting comments from' do |*file_names|
        context '.extract_comments' do
          raise 'file_names did not given' if file_names.empty?

          file_names.each do |file_name|
            context "given a content of #{file_name}" do
              let(:path) { source_code_path(file_name) }
              let(:content) { File.open(path) { |f| f.read } }
              let(:expected_comments) do
                content.split("\n").each_with_object({}) do |line, memo|
                  if %r!(?<comment>\[-(?<line_number>\d+)-\].*)$! =~ line
                    comment.sub!(/(?<=\[-end-\]).*$/, '') if comment =~ /\[-end-\]/
                    memo[line_number.to_i] = comment
                  end
                end
              end
              let(:extracted_comments) { scanner.extract_comments }

              it 'scans content' do
                expect { extracted_comments }.to extract_comment(expected_comments)
              end
            end
          end
        end
      end

      shared_examples_for 'detecting shebang' do |*shebangs|
        shebangs.each do |shebang|
          it 'detects shebang' do
            expect(shebang).to match scanner.class.shebang
          end
        end
      end
    end
  end
end
