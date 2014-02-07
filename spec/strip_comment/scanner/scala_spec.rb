require 'spec_helper'

class StripComment::Scanner
  describe Scala do
    subject { Scala }
    it { should include Concerns::SlashScanner }
  end
end
