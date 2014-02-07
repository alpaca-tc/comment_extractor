require 'spec_helper'

module StripComment
  describe Stripper do
    let(:options) { { root_path: root_path } }
    let(:root_path) { File.dirname(__FILE__) }
    let(:stripper) { Stripper.new(options) }

    describe 'ClassMethods' do
      describe '.new' do
        subject { stripper }

        its(:configuration) { should be_an_instance_of(Configuration) }

        context 'given block' do
          subject { stripper.configuration }
          let(:stripper) { Stripper.new(options, &block) }
          let(:block) { Proc.new { |c| c.dry_run = true } }

          # [review] - This test is depends on Configuration
          it 'initializes Configuration by block' do
            expect(subject.dry_run).to be_true
          end
        end

        context 'given hash of options' do
          subject { stripper.configuration }
          let(:options) { { root_path: File.dirname(__FILE__), dry_run: true } }

          # [review] - This test is depends on Configuration
          it 'initializes Configuration by hash' do
            expect(subject.dry_run).to be_true
          end
        end
      end
    end

    describe 'InstanceMethods' do
      describe '#list_up_files' do
        subject { stripper.list_up_files }

        let(:root_path) { File.expand_path('../../assets/stripper', __FILE__) }
        let(:expected) do
          %w[
          children/children.c children/children
          children/children.js children/children.o
          children/children.rb test
          test.c test.js test.o test.rb
          ].map { |v| File.expand_path(v, root_path) }.sort
        end

        it 'returns array contains list of files' do
          expect(subject).to eql expected
        end
      end

      describe '#comments' do
        subject { stripper.comments }
        let(:root_path) { File.expand_path('../../assets/stripper', __FILE__) }

        it 'returns array contains list of instances of CodeObject::Comment' do
          expect(subject[0]).to be_an_instance_of(CodeObject::Comment)
        end
      end

      describe '#enabled_file?' do
        subject { stripper.send(:enabled_file?, file_path) }

        context 'when file_path matchs excepted regexp' do
          let(:options) { { root_path: root_path, ignore_list: ignore_list } }
          let(:ignore_list) { [/\.rb$/] }
          let(:file_path) { File.expand_path('../bar.rb', __FILE__) }

          it { should be_false }
        end

        context 'when file_path does not match excepted regexp' do
          let(:options) { { root_path: root_path, ignore_list: [] } }
          let(:file_path) { File.expand_path('../bar.rb', __FILE__) }

          it { should be_true }
        end

        context 'when file_path is directory' do
          let(:options) { { root_path: root_path, ignore_list: [] } }
          let(:file_path) { File.expand_path('..', __FILE__) }

          it { should be_false }
        end
      end
    end
  end
end
