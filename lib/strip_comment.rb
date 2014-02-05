require 'strip_comment/version'

module StripComment
  autoload :Encoding, 'strip_comment/encoding'
  autoload :Scanner, 'strip_comment/scanner'
  autoload :Parser, 'strip_comment/parser'
  autoload :FileObject, 'strip_comment/file_object'
  # [todo] - Initializes code_object for comment, code and as so on
  # [todo] - Defines method to parses file
end
