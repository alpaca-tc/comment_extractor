require 'spec_helper'

describe 'CommentParser::Version' do
  subject { CommentParser }
  it { should be_const_defined(:Version) }
  it { should be_const_defined(:VERSION) }
end
