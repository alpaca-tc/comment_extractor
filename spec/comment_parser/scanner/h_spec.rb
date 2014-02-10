require 'spec_helper'

class CommentParser::Scanner
  describe H do
    subject { H }
    it { should include Concerns::SlashScanner }
  end
end
