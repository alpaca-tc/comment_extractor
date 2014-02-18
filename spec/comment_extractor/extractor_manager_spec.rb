require 'spec_helper'
require 'comment_extractor/extractor_manager'

module CommentExtractor
  describe ExtractorManager do
    after do
      if described_class.instance_variable_defined?(:@extractors)
        described_class.send(:remove_instance_variable, :@extractors)
      end
    end

    def registered_extractors
      described_class.instance_variable_get(:@extractors)
    end

    describe 'PublicModuleMethods' do
      describe '.regist_extractor' do
        subject { registered_extractors }

        before do
          described_class.regist_extractor(extractor)
        end

        let(:extractor) { :Object }

        context "given a extractor's symbol or Klass" do
          it 'registers a extractor to self' do
            expect(subject).to have_key(extractor)
          end
        end
      end

      describe '.default_extractors' do
        subject { described_class.default_extractors }

        it 'returns Array contains default extractors' do
          expect(subject).to be_an_instance_of Array
        end
      end
    end

    describe 'Finding extractor methods' do
      before do
        described_class.instance_variable_set(:@extractor_definitions, definitions)
      end

      let(:definitions) do
        {
          shebang: {
            regexp: /(\/node$)|(ruby$)/,
            values: ['JavaScript', 'Ruby']
          },
          filename: {
            regexp: /(\.js$)|(\.rb$|Gemfile$|Rakefile)/,
            values: ['JavaScript', 'Ruby']
          },
          filetype: {
            'key' => 'value',
          }
        }
      end

      shared_context 'trying to find extractor' do
        context 'given a registered value' do
          let(:test_value) { registed_value }
          it 'finds ExtractorKlass' do
            should eql 'Ruby'
          end
        end

        context 'given a non-matching string' do
          let(:test_value) { '' }
          it { should be_nil }
        end
      end

      describe '.find_extractor_by_shebang' do
        subject { described_class.find_extractor_by_shebang(test_value) }
        let(:registed_value) { '#! /usr/local/ruby' }

        it_behaves_like 'trying to find extractor'
      end

      describe '.find_extractor_by_filename' do
        subject { described_class.find_extractor_by_filename(test_value) }
        let(:registed_value) { 'path/to/file.rb' }

        it_behaves_like 'trying to find extractor'
      end

      describe '.find_extractor_by_filetype' do
        subject { described_class.find_extractor_by_filetype('key') }

        it 'finds ExtractorKlass by matching file type' do
          should eql 'value'
        end
      end

      describe '.can_extract' do
        subject { described_class.can_extract(file_path) }

        before do
          allow(File).to receive(:binary?).with(file_path) { binary? }
          allow(File).to receive(:shebang).with(file_path) { shebang }
        end

        let(:file_path) { '/path/to/file' }
        let(:shebang) { nil }
        let(:binary?) { false }

        context 'given a binary file' do
          let(:binary?) { true }
          it { should be_nil }
        end

        context 'given a file that does not contain shebang' do
          let(:file_path) { '/path/to/ruby.rb' }

          it 'finds ExtractorKlass by file name' do
            should eql 'Ruby'
          end
        end

        context 'given a file that contains shebang' do
          let(:shebang) { '/usr/bin/node' }

          it 'finds ExtractorKlass by shebang' do
            should eql 'JavaScript'
          end
        end
      end
    end

    context 'PrivateModuleMethods' do
      describe '.initialize_extractors!' do
        subject { registered_extractors }

        let(:described_method) { described_class.send(:initialize_extractors!) }
        let(:default_extractors) { ExtractorManager.default_extractors }

        it 'initializes extractors' do
          expect(subject).to be_nil
          described_method
          expect(registered_extractors.keys).to match_array default_extractors
        end
      end

      describe '.build_extractor_definitions' do
        subject { described_class.send(:build_extractor_definitions) }

        before do
          allow(described_class).to receive(:extractors).and_return(extractors)
        end

        def build_extractor(name)
          double.tap do |e|
            allow(e).to receive(:disabled?).and_return(false)
            allow(e).to receive(:shebang).and_return(/#{name}/)
            allow(e).to receive(:filetype).and_return(name)
            allow(e).to receive(:filename).and_return(/\.#{name}$/)
          end
        end

        let(:extractors) do
          {
            Ruby: ruby_extractor,
            Php: php_extractor,
          }
        end
        let(:php_extractor) { build_extractor('php') }
        let(:ruby_extractor) { build_extractor('ruby') }
        let(:expected_regexp) do
          {
            shebang: /(ruby)|(php)/,
            filename: /(\.ruby$)|(\.php$)/,
            filetype: {
              'php' => php_extractor,
              'ruby' => ruby_extractor,
            },
          }
        end
        let(:defined_extractor_finders) do
          described_class.send(:defined_extractor_finders)
        end

        it 'builds extractor definitions' do
          expect(subject).to be_an_instance_of Hash

          [:filename, :shebang].each do |finder|
            expect(subject[finder]).to be_an_instance_of Hash
            expect(subject[finder][:regexp]).to eql expected_regexp[finder]
            expect(subject[finder][:values]).to be_an_instance_of Array
          end

          expect(subject[:filetype]).to eql expected_regexp[:filetype]
        end
      end
    end
  end
end
