require 'spec_helper'

class CommentParser::Scanner
  describe Lua do
    let(:file_path) { 'lua.lua' }
    it_behaves_like 'scanning source code'
  end
end
