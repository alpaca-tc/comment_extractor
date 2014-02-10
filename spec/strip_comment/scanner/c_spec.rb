require 'spec_helper'

class CommentParser::Scanner
  describe C do
    subject { C }
    it { should include Concerns::SlashScanner }
  end
end
