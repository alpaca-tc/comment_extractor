require 'spec_helper'

class CommentParser::Scanner
  describe Cs do
    subject { Cs }
    it { should include Concerns::SlashScanner }
  end
end
