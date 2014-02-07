require 'spec_helper'

class StripComment::Scanner
  describe Cpp do
    subject { Cpp }
    it { should include Concerns::SlashScanner }
  end
end
