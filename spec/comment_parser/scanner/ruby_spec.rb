require 'spec_helper'

describe CommentExtractor::Scanner::Ruby do
  it_behaves_like 'detecting shebang', '/usr/local/bin/ruby'
  it_behaves_like 'scanning source code'
end
