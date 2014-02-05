require 'rspec'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'strip_comment'

RSpec.configure do |config|
  config.order = 'random'
end
