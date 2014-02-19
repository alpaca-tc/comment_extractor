require 'rspec'

begin
  require 'coveralls'
  Coveralls.wear!
rescue LoadError
end

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../support', __FILE__)
require 'rspec/comment_extractor'

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = true
  config.raise_errors_for_deprecations!
  config.include RSpec::CommentExtractor::ExtractorExampleGroup, type: :extractor, example_group: {
    file_path: Regexp.compile(%w[spec comment_extractor extractor .*.rb].join('[\\\/]'))
  }
  config.source_code_path = 'spec/assets/source_code'
end
