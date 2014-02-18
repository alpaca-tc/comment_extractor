require 'spec_helper'
require 'comment_extractor/extractor/perl'

class CommentExtractor::Extractor
  describe Perl do
    it_behaves_like 'extracting comments from', 'perl.pl'
    it_behaves_like 'detecting filename', 'file.pl'
  end
end
