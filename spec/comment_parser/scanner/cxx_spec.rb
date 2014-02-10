require 'spec_helper'

class CommentParser::Scanner
  describe Cxx do
    subject { Cxx }
    it { should include Concerns::SlashScanner }
  end
end
