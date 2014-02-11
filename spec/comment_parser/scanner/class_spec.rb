require 'spec_helper'

class CommentParser::Scanner
  describe Class do
    # [todo] - Please give me .class sample
    subject { Class }
    it { should include Concerns::SlashScanner }
  end
end
