require 'strip_comment/version'

module StripComment
  autoload :Encoding, 'strip_comment/encoding'
  autoload :Scanner, 'strip_comment/scanner'
  autoload :Parser, 'strip_comment/parser'
  autoload :FileObject, 'strip_comment/file_object'
  autoload :CodeObject, 'strip_comment/code_object'
  autoload :Configuration, 'strip_comment/configuration'
  # [todo] - Defines method to parses file
end
