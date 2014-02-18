require 'spec_helper'
require 'comment_extractor'

describe CommentExtractor do
  describe 'ClassMethods' do
    describe '.configuration' do
      subject { described_class.configuration }
      it { should be_an_instance_of CommentExtractor::Configuration }
    end

    describe '.configure' do
      it { expect { |b| described_class.configure(&b) }.to yield_control }
    end
  end
end
