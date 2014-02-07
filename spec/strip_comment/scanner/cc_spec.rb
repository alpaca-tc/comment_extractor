require 'spec_helper'

class StripComment::Scanner
  describe Cc do
    subject { Cc }
    it { should include Concerns::SlashScanner }
  end
end
