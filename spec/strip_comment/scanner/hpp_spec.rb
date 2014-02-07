require 'spec_helper'

class StripComment::Scanner
  describe Hpp do
    subject { Hpp }
    it { should include Concerns::SlashScanner }
  end
end
