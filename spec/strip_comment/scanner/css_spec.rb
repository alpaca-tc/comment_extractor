require 'spec_helper'

class CommentParser::Scanner
  describe Css do
    subject { Css }
    it { should include Concerns::SlashScanner }
  end
end
