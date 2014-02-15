require 'spec_helper'
require 'comment_extractor/version'

describe 'CommentExtractor::Version' do
  subject { CommentExtractor }
  it { should be_const_defined(:Version) }
  it { should be_const_defined(:VERSION) }
end
