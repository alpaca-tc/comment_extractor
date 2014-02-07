require 'spec_helper'

class StripComment::Scanner
  describe H do
    subject { H }
    it { should include Concerns::SlashScanner }
  end
end
