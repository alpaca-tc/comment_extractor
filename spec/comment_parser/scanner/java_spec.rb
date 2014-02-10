require 'spec_helper'

class CommentParser::Scanner
  describe Java do
    subject { Java }
    it { should include Concerns::SlashScanner }
  end
end
