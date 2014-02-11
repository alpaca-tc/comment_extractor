require 'spec_helper'

describe CommentParser::Scanner::JavaScript do
  it_behaves_like 'detecting shebang', '/usr/local/bin/node'
  it_behaves_like 'scanning source code'
end
