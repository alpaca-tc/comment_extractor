require 'strip_comment/version'

module StripComment
  autoload :CodeObject, 'strip_comment/code_object'
  autoload :Configuration, 'strip_comment/configuration'
  autoload :Encoding, 'strip_comment/encoding'
  autoload :FileObject, 'strip_comment/file_object'
  autoload :Parser, 'strip_comment/parser'
  autoload :Scanner, 'strip_comment/scanner'
  autoload :Stripper, 'strip_comment/stripper'
end
