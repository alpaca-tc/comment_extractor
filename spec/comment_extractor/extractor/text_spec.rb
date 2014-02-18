require 'spec_helper'
require 'comment_extractor/extractor/text'

describe CommentExtractor::Extractor::Text do
  it_behaves_like 'extracting comments from', 'text.txt'
  it_behaves_like 'detecting filename', 'file.txt'
end
