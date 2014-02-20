require 'spec_helper'
require 'comment_extractor/configuration'

module CommentExtractor
  describe Configuration do
    before do
      # Initializes class variables
      @required_attributes = described_class.instance_variable_set(:@required_attributes, {})

      described_class.instance_variable_set(:@required_attributes, {})
    end

    after do
      # Restores class variables
      described_class.instance_variable_set(:@required_attributes, @required_attributes)
    end

    describe '.new' do
      subject { CommentExtractor::Configuration.new(options) }
      let(:options) { {} }

      context 'given valid attributes' do
        it 'sets attributes to default value' do
          expect(subject.extractors).to eql Extractors.default_extractors
          expect(subject.default_extractor).to eql Extractor::Text
          expect(subject.use_default_extractor).to be_truthy
        end
      end

      context 'given invalid attributes' do
        before do
          described_class.add_setting :required_attribute, required: true
        end

        it "raises 'Unable to initialize :key without attribute' as #{ArgumentError}" do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end

    describe '.add_setting' do
      subject { described_class.new(option_of_initialization) }

      before do
        described_class.send(:add_setting, name, option_of_setting)
      end

      let(:name) { :setting_name }
      let(:option_of_setting) { {} }
      let(:option_of_initialization) { {} }

      context 'given setting name' do
        it 'defines accessor method' do
          should be_respond_to name
          should be_respond_to "#{name}="
        end
      end

      context 'given predicate option' do
        let(:option_of_setting) { { predicate: true } }
        let(:method) { :"#{name}?" }

        it 'defines predicate method(:name?)' do
          expect(subject).to be_respond_to(method)
          expect(subject.send(method)).to be_falsy
        end
      end

      context 'given required option' do
        let(:option_of_setting) { { required: true } }

        context 'when to initialize configuration without required attribute' do
          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context 'when to initialize configuration with required attribute' do
          let(:option_of_initialization) { { name => true } }
          it { expect { subject }.to_not raise_error }
        end
      end
    end
  end
end
