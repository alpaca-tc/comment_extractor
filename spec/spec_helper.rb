require 'rspec'
require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rspec/comment_extractor'

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = true
  config.show_failures_in_pending_blocks = true
  config.raise_errors_for_deprecations!
  config.include RSpec::CommentExtractor::ExtractorExampleGroup, type: :extractor, example_group: {
    file_path: Regexp.compile(%w[spec comment_extractor extractor .*.rb].join('[\\\/]'))
  }
  config.source_code_path = 'spec/assets/source_code'
end
