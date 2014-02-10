require 'spec_helper'

class CommentParser::Scanner
  describe Scss do
    subject { Scss }
    it { should include Concerns::SlashScanner }
  end
end
