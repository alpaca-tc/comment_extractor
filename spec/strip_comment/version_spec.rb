require 'spec_helper'

describe 'StripComment::Version' do
  subject { StripComment }
  it { should be_const_defined(:Version) }
  it { should be_const_defined(:VERSION) }
end
