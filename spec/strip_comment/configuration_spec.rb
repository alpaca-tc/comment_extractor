require 'spec_helper'

describe StripComment::Configuration do
  after do
    # Initializes class variables
    StripComment::Configuration.class_variable_set(:@@default_values, {})
    StripComment::Configuration.class_variable_set(:@@required_attributes, {})
  end

  describe '.new' do
    subject { StripComment::Configuration.new(options) }
    let(:options) { { root_path: File.dirname(__FILE__) } }

    it 'sets attributes to default value' do
      expect(subject.dry_run).to be_false
      expect(subject.files).to eql []
      expect(subject.directories).to eql []
      expect(subject.ignore_list).to eql []
    end
  end

  describe '.add_setting' do
    subject { StripComment::Configuration.new(option_of_initialize) }
    let(:name) { :setting_name }
    let(:option_of_initialize) { {} }
    let(:option_of_setting) { {} }

    before do
      StripComment::Configuration.send(:add_setting, name, option_of_setting)
    end

    context 'given setting name' do
      it {
        should be_respond_to name
        should be_respond_to "#{name}="
      }
    end

    context 'given default option' do
      let(:default_value) { 'default value' }
      let(:option_of_setting) { { default: default_value } }

      it 'initializes value by defualt value' do
        expect(subject.send(name)).to eql default_value
      end
    end

    context 'given predicate option' do
      let(:option_of_setting) { { predicate: true } }

      it 'defines predicate method(:name?)' do
        expect(subject).to be_respond_to("#{name}?")
      end
    end

    context 'given required option' do
      let(:option_of_setting) { { required: true } }

      context 'when initializes configuration without required attribute' do
        let(:message) { "Unable to initialize #{name} without attribute" }
        it { expect { subject }.to raise_error(message) }
      end

      context 'when initializes configuration with required attribute' do
        let(:option_of_initialize) { { name => true } }
        it { expect { subject }.to_not raise_error }
      end
    end
  end
end
