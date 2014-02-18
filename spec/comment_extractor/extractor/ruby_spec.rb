require 'spec_helper'
require 'comment_extractor/extractor/ruby'

class CommentExtractor::Extractor
  describe Ruby do
    it_behaves_like 'detecting shebang', '/usr/local/bin/ruby'
    it_behaves_like 'extracting comments from', 'ruby.rb'

    filenames = %w[file.rb Gemfile Rakefile file.gemspec Guardfile]
    it_behaves_like 'detecting filename', *filenames
  end
end
