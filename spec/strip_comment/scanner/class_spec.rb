require 'spec_helper'

class CommentParser::Scanner
  describe Class do
    subject { Class }
    it { should include Concerns::SlashScanner }
  end
end
