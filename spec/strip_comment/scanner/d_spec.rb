require 'spec_helper'

class StripComment::Scanner
  describe D do
    subject { D }
    it { should include Concerns::SlashScanner }
  end
end
