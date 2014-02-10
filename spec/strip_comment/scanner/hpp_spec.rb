require 'spec_helper'

class CommentParser::Scanner
  describe Hpp do
    subject { Hpp }
    it { should include Concerns::SlashScanner }
  end
end
