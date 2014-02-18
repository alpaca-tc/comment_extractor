require 'spec_helper'
require 'comment_extractor/extractor/yaml'

class CommentExtractor::Extractor
  describe Yaml do
    it_behaves_like 'extracting comments from', 'yaml.yml'
    it_behaves_like 'detecting filename', 'file.yml'
  end
end
