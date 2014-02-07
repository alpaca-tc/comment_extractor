require 'spec_helper'

class StripComment::Scanner
  describe Java do
    subject { Java }
    it { should include Concerns::SlashScanner }
  end
end
