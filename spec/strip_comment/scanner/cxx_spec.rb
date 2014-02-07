require 'spec_helper'

class StripComment::Scanner
  describe Cxx do
    subject { Cxx }
    it { should include Concerns::SlashScanner }
  end
end
