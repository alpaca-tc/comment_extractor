require 'comment_parser/version'

module CommentParser
  autoload :CodeObject, 'comment_parser/code_object'
  autoload :Configuration, 'comment_parser/configuration'
  autoload :Encoding, 'comment_parser/encoding'
  autoload :File, 'comment_parser/file_object'
  autoload :Parser, 'comment_parser/parser'
  autoload :Scanner, 'comment_parser/scanner'
  autoload :Stripper, 'comment_parser/stripper'
end
