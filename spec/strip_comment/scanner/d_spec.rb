require 'spec_helper'

class CommentParser::Scanner
  describe D do
    subject { D }
    it { should include Concerns::SlashScanner }
  end
end
