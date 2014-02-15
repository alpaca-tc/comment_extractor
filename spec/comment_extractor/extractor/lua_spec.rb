require 'spec_helper'

class CommentExtractor::Extractor
  describe Lua do
    let(:file_path) { 'lua.lua' }
    it_behaves_like 'scanning source code'
  end
end
