require 'spec_helper'
require 'comment_extractor/extractor_manager'

module CommentExtractor
  describe ExtractorManager do
    before do
      if described_class.instance_variable_defined?(:@extractors)
        described_class.send(:remove_instance_variable, :@extractors)
      end
    end

    describe 'ClassMethods' do
      describe '.regist_extractor' do
        subject { described_class.instance_variable_get(variable_name) }
        let(:variable_name) { :@extractors }
        let(:extractor) { :Object }

        before do
          described_class.regist_extractor(extractor)
        end

        shared_context 'registering extractor' do
          it 'registers a extractor to self' do
            expect(subject[extractor]).to be_nil
          end
        end

        context 'when extractors have already initialized' do
          let(:expected_extractors) do
            described_class.default_extractors + [extractor]
          end

          it 'registors extractors by .initialize_extractors!' do
            expect(subject.keys).to match_array expected_extractors
          end

          it_behaves_like 'registering extractor'
        end

        context 'when extractors have not initialized yet' do
          it_behaves_like 'registering extractor'
        end
      end

      describe '.default_extractors' do
        subject { described_class.default_extractors }

        it 'returns Array contains default extractors' do
          expect(subject).to be_an_instance_of Array
        end
      end

      describe '.initialize_extractors!' do
        before do
          described_class.send(:initialize_extractors!)
        end

        subject { described_class.instance_variable_get(:@extractors).keys }

        it 'initializes extractors' do
          expect(subject).to match_array ExtractorManager.default_extractors
        end
      end

      describe '.build_extractor_definitions' do
        subject { described_class.send(:build_extractor_definitions) }

        before do
          allow(described_class).to receive(:defined_extractor_finder)
            .and_return(defined_extractor_finder)
          described_class.instance_variable_set(:@extractors, { v: extractor  })
        end

        let(:defined_extractor_finder) { [:shebang] }
        let(:extractor) do
          double.tap do |e|
            allow(e).to receive(:shebang).and_return(%r!/usr/local/shebang!)
          end
        end

        # [review] - This test is insufficiency
        it 'build extractor definitions' do
          expect(subject).to be_an_instance_of Hash

          defined_extractor_finder.each do |finder|
            expect(subject[finder]).to be_an_instance_of Hash
            expect(subject[finder][:regexp]).to be_an_instance_of Regexp
            expect(subject[finder][:values]).to be_an_instance_of Array
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
              regexp: /(\.js$)|(\.rb$)/,
              values: ['JavaScript', 'Ruby']
            }
          }
        end

        describe '.find_extractor_by_...' do
          shared_context 'trying to find extractor' do
            context 'given a registed value' do
              let(:value_of_giving) { registed_value }
              it 'finds Extractor by shebang' do
                should eql 'Ruby'
              end
            end

            context 'given a empty string' do
              let(:value_of_giving) { '' }
              it { should be_nil }
            end
          end

          describe '.find_extractor_by_shebang' do
            subject { described_class.find_extractor_by_shebang(value_of_giving) }
            let(:registed_value) { '#! /usr/local/ruby' }

            it_behaves_like 'trying to find extractor'
          end

          describe '.find_extractor_by_filename' do
            subject { described_class.find_extractor_by_filename(value_of_giving) }
            let(:registed_value) { 'path/to/file.rb' }

            it_behaves_like 'trying to find extractor'
          end
        end

        describe '.can_extract' do
          subject { described_class.can_extract(path) }

          before do
            allow(described_class).to receive(:defined_extractor_finder)
              .and_return([:filename, :shebang])
            allow(File).to receive(:new).and_return(file)
          end

          let(:binary?) { false }
          let(:content) { '' }
          let(:path) { '/path/to/file' }
          let(:shebang) { nil }
          let(:file) do
            double.tap do |f|
              allow(f).to receive(:shebang) { shebang }
              allow(f).to receive(:content) { content }
              allow(f).to receive(:binary?) { binary? }
              allow(f).to receive(:path) { path }
            end
          end

          context 'given a file which has a file extension' do
            let(:path) { '/path/to/ruby.rb' }

            it 'finds ExtractorKlass by file name' do
              should eql 'Ruby'
            end
          end

          context 'given a binary file' do
            let(:binary?) { true }
            it { should be_nil }
          end

          context 'given a file which contains shebang' do
            let(:shebang) { '/usr/bin/node' }

            it 'finds ExtractorKlass by shebang' do
              should eql 'JavaScript'
            end
          end
        end
      end
    end
  end
end
