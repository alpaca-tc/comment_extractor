require 'spec_helper'

class StripComment::Scanner
  describe Php do
    subject { Php }
    it { should include Concerns::SlashScanner }
    it { pending 'Implementation scanner' }
  end
end
