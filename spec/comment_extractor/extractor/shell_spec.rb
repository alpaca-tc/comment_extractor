require 'spec_helper'
require 'comment_extractor/extractor/shell'

class CommentExtractor::Extractor
  describe Shell do
    it_behaves_like 'extracting comments from', 'shell.sh'
    it_behaves_like 'detecting filename', 'file.sh', 'file.zsh', 'file.bash', 'bashrc', 'zshrc'
  end
end
