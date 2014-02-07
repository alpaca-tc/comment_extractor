require 'spec_helper'

class StripComment::Scanner
  describe Mm do
    subject { Mm }
    it { should include Concerns::SlashScanner }
  end
end
