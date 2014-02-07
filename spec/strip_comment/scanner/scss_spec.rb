require 'spec_helper'

class StripComment::Scanner
  describe Scss do
    subject { Scss }
    it { should include Concerns::SlashScanner }
  end
end
