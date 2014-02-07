require 'spec_helper'

class StripComment::Scanner
  describe M do
    subject { M }
    it { should include Concerns::SlashScanner }
  end
end
