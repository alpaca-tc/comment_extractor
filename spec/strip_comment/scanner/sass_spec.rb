require 'spec_helper'

class CommentParser::Scanner
  describe Sass do
    subject { Sass }
    it { should include Concerns::SlashScanner }
  end
end
