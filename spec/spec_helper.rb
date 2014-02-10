require 'rspec'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'comment_parser'

RSpec.configure do |config|
  config.order = 'random'
end
