require 'spec_helper'
require 'comment_extractor/extractor/ruby'

describe CommentExtractor::Extractor::Ruby do
  it_behaves_like 'detecting shebang', '/usr/local/bin/ruby'
  it_behaves_like 'extracting comments from', 'ruby.rb'
end
