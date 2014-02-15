require 'spec_helper'
require 'comment_extractor/extractor/sql'

class CommentExtractor::Extractor
  describe Sql do
    it_behaves_like 'extracting comments from', 'sql.sql'
  end
end
