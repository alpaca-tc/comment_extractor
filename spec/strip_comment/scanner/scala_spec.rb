require 'spec_helper'

class CommentParser::Scanner
  describe Scala do
    subject { Scala }
    it { should include Concerns::SlashScanner }
  end
end
