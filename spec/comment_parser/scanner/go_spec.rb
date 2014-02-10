require 'spec_helper'

class CommentParser::Scanner
  describe Go do
    subject { Go }
    it { should include Concerns::SlashScanner }
  end
end
