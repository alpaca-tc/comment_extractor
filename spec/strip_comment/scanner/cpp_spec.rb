require 'spec_helper'

class CommentParser::Scanner
  describe Cpp do
    subject { Cpp }
    it { should include Concerns::SlashScanner }
  end
end
