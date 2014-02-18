RSpec.configure do |config|
  config.add_setting :source_code_path, default: 'spec/assets/source_code'
end

module RSpec::CommentExtractor::ExtractorExampleGroup
  include RSpec::CommentExtractor::Matchers::ExtractComment

  def build_extractor(content = nil)
    described_class.new(content)
  end

  def source_code_path(file_name = nil)
    dir = RSpec.configuration.source_code_path
    file_name ? "#{dir}/#{file_name}" : dir
  end

  def self.included(k)
    k.class_eval do
      # Initialize shared_examples
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
              let(:extracted_comments) { extractor.extract_comments }

              it 'scans content' do
                expect { extracted_comments }.to extract_comment(expected_comments)
              end
            end
          end
        end
      end

      shared_examples_for 'a schema' do |key, *expected_list|
        let(:schema) { extractor.class.send(key) }

        expected_list.each do |expected|
          context "Given '#{expected}'" do
            it "detects extractor" do
              expect(expected).to match schema
            end
          end
        end

        # Schema does not have to contain group regexp because of the optimization.
        it 'does not contain group regexp; You need to remove `/()/`' do
          matcher = Regexp.new([schema.source, /.*/.source].join('|'))

          expect(matcher.match('_').length).to eql 1
        end
      end

      shared_examples_for 'detecting shebang' do |*shebangs|
        describe '.shebang' do
          it_behaves_like 'a schema', :shebang, *shebangs
        end
      end

      shared_examples_for 'detecting filename' do |*filenames|
        describe '.filename' do
          it_behaves_like 'a schema', :filename, *filenames
        end
      end

      # Initialize example groups and run test
      metadata[:type] = :extractor

      let(:content) { '' }
      let(:extractor) { build_extractor(content) }

      context '.filetype' do
        subject { extractor.class.filetype }

        it 'should be defined' do
          should_not be_nil
        end

        it 'defines a instance of Array or String' do
          string_or_array = subject.is_a?(String) || subject.is_a?(Array)
          expect(string_or_array).to be_truthy
        end
      end

      # Skips test when extractor has already disabled
      if metadata[:disabled]
        shared_examples_for 'disabled' do
          subject { described_class.disabled? }
          it { expect(subject).to be_truthy }
        end

        it_behaves_like 'disabled'

        pending 'disabled extractor'

        next
      else
        context '.new' do
          it { expect { extractor }.to_not raise_error }
        end
      end
    end
  end
end
