require 'spec_helper'

module StripComment
  describe Stripper do
    let(:options) { { root_path: root_path } }
    let(:root_path) { File.dirname(__FILE__) }

    describe '.new' do
      subject { Stripper.new(options) }

      its(:configuration) { should be_an_instance_of(Configuration) }

      context 'given block' do
        subject { Stripper.new(options, &block).configuration }
        let(:block) { Proc.new { |c| c.dry_run = true } }

        # [review] - This test is depends on Configuration
        it 'initializes Configuration by block' do
          expect(subject.dry_run).to be_true
        end
      end

      context 'given hash of options' do
        subject { Stripper.new(options).configuration }
        let(:options) { { root_path: File.dirname(__FILE__), dry_run: true } }

        # [review] - This test is depends on Configuration
        it 'initializes Configuration by hash' do
          expect(subject.dry_run).to be_true
        end
      end
    end

    describe '#list_up_files' do
      subject { Stripper.new(options).list_up_files }

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
      subject { Stripper.new(options).comments }
      let(:root_path) { File.expand_path('../../assets/stripper', __FILE__) }

      it 'returns array contains list of instance of CodeObject::Comment' do
        expect(subject[0]).to be_an_instance_of(CodeObject::Comment)
      end
    end
  end
end
