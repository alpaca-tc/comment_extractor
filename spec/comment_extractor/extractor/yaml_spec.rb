require 'spec_helper'
require 'comment_extractor/extractor/yaml'

class CommentExtractor::Extractor
  describe Yaml do
    it_behaves_like 'extracting comments from', 'yaml.yaml'
    it_behaves_like 'detecting filename', 'file.yaml'
  end
end
