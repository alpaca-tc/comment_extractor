require 'spec_helper'

class StripComment::Scanner
  describe Go do
    subject { Go }
    it { should include Concerns::SlashScanner }
  end
end
