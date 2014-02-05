require 'spec_helper'

describe StripComment::Scanner do
  let(:file_object) { StripComment::FileObject.new(file_path) }
  let(:file_path) { __FILE__ }

  subject { StripComment::Scanner.new(file_object, file_object.content) }

  it { expect { subject }.to_not raise_error }
  it { expect { subject.scan }.to raise_error('Neet to implement') }
end
