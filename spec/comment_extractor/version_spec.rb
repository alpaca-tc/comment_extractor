require 'spec_helper'

describe 'CommentExtractor::Version' do
  subject { CommentExtractor }
  it { should be_const_defined(:Version) }
  it { should be_const_defined(:VERSION) }
end
