require 'spec_helper'

class CommentParser::Scanner
  describe C do
    let(:source_code) { CommentParser::FileObject.new(source_code_path('c.c')) }
    it_behaves_like 'scanning source code'
  end
end
