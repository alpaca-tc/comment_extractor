# [todo] - require each file
require 'comment_extractor/version'

module CommentExtractor
  autoload :CodeObject, 'comment_extractor/code_object'
  autoload :Configuration, 'comment_extractor/configuration'
  autoload :Encoding, 'comment_extractor/encoding'
  autoload :File, 'comment_extractor/file'
  autoload :Parser, 'comment_extractor/parser'
  autoload :Extractor, 'comment_extractor/extractor'
end
