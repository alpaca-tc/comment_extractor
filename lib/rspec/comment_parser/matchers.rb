require 'rspec/expectations'

module RSpec::CommentExtractor
  module Matchers
  end
end

Dir[File.expand_path('../matchers/*.rb', __FILE__)].each { |f| require f }
