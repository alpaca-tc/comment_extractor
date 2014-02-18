require 'spec_helper'
require 'comment_extractor/extractor/lua'

class CommentExtractor::Extractor
  describe Lua do
    it_behaves_like 'extracting comments from', 'lua.lua'
    it_behaves_like 'detecting filename', 'file.lua'
  end
end
