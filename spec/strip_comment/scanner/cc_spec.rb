require 'spec_helper'

class StripComment::Scanner
  describe Css do
    subject { Css }
    it { should include Concerns::SlashScanner }
  end
end
