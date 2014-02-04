require 'spec_helper'

describe StripComment::Scanner do
  subject { StripComment::Scanner.new(nil) }

  it { expect { subject.scan }.to raise_error('Neet to implement') }
end
