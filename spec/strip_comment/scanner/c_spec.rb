require 'spec_helper'

class StripComment::Scanner
  describe C do
    subject { C }
    it { should include Concerns::SlashScanner }
  end
end
