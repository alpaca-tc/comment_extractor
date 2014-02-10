require 'spec_helper'

class CommentParser::Scanner
  describe M do
    subject { M }
    it { should include Concerns::SlashScanner }
  end
end
