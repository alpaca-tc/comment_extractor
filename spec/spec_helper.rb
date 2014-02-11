require 'rspec'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'comment_parser'
require 'rspec/comment_parser'

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = true
  config.show_failures_in_pending_blocks = true
  config.raise_errors_for_deprecations!
  config.include RSpec::CommentParser::ScannerExampleGroup, type: :scanner, example_group: {
    file_path: Regexp.compile(%w[spec comment_parser scanner .*.rb].join('[\\\/]'))
  }
  config.source_code_path = 'spec/assets/source_code'
end
