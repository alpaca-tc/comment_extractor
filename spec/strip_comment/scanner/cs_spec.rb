require 'spec_helper'

class StripComment::Scanner
  describe Cs do
    subject { Cs }
    it { should include Concerns::SlashScanner }
  end
end
