require 'spec_helper'

class CommentParser::Scanner
  describe Mm do
    subject { Mm }
    it { should include Concerns::SlashScanner }
  end
end
