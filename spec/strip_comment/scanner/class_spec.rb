require 'spec_helper'

class StripComment::Scanner
  describe Class do
    subject { Class }
    it { should include Concerns::SlashScanner }
  end
end
