require 'comment_extractor/code_object'
require 'comment_extractor/configuration'
require 'comment_extractor/encoding'
require 'comment_extractor/extractor'
require 'comment_extractor/file'
require 'comment_extractor/parser'
require 'comment_extractor/version'

module CommentExtractor
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
