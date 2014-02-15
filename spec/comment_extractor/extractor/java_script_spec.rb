require 'spec_helper'
require 'comment_extractor/extractor/java_script'

describe CommentExtractor::Extractor::JavaScript do
  it_behaves_like 'detecting shebang', '/usr/local/bin/node'
  it_behaves_like 'extracting comments from', 'java_script.js'
end
