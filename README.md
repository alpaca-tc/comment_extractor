# strip\_comment

[![Gem Version](https://badge.fury.io/rb/comment_parser.png)](http://badge.fury.io/rb/comment_parser) [![Build Status](https://travis-ci.org/alpaca-tc/comment_parser.png?branch=develop)](https://travis-ci.org/alpaca-tc/comment\_parser)

## Description

*Simple tokenizer for taking out only a comment out*

comment\_parser takens out only a comment out from a source code.

## Installation

CommentParser has been tested with ruby 2.1.

```sh
git clone https://github.com/alpaca-tc/comment_parser
cd comment_parser
rake install
```

## Usage

### Parser

Parser is wrapper around scanners.
When given a file to `Parser.for`, CommentParser::Parser returns parser of file given.

```ruby
require 'comment_parser'

path = 'path/to/file'
if parser = CommentParser::Parser.for(path)
  comments = parser.parse
  comment = comments.first
  comemnt.is_a?(CommentParser::CodeObject::Comment)
  comment.file  #=> #<CommentParser::File:path/to/file>
  comment.line  #=> 1
  comment.value #=> 'I am a comment'
end
```

### Scanner

```ruby
require 'comment_parser'

file = CommentParser::File.new('path/to/file.rb')
if scanner_klass = CommentParser::Parser.find_scanner_by_filetype('ruby')
  scanner = scanner_klass.new(file)
  scanner.scan
  p scanner.comments #=> [#<CommentParser::CodeObject::Comment:0x007f98cb90c4f8>, ...]
end
```

### Supported FileTypes

- **C / C++**
- **C#**
- **Java**
- **JavaScript**
- **PHP**
- **Go**
- **Scala**
- **Erlang**
- **Fortran**
- **SQL / PL**
- **Lua**
- **HTML**
- **SASS SCSS**
- **Haskell**
- **Bash / Zsh**
- **Ruby**
- **Perl**
- **Python**
- **Coffee-Script**
- **Clojure**
- **HTML**
- **Emacslisp**
- **LaTex**

### Create new Scanner

If you see something missing from the supported filetype, please either file an issue or submit a pull request:)

```ruby
# lib/comment_parser/scanner/new_file_type.rb

class CommentParser::Scanner::NewFileType < CommentParser::Scanner
  include CommentParser::Scanner::Concerns::SimpleScanner

  filename /\.(extention)$/
  filetype 'filetype' #=> g.u 'ruby', 'php'

  # ignore pattern
  # define_ignore_patterns(*given regexp)

  # define_bracket('"') #=> ignore /".*?(?<!\\)"/
  # define_regexp_bracket #=> ignore %r!/(?=[^/])!, /(?<!\\)\//

  # define the rule of comment
  define_rule start: /;+/
  define_rule start: /;--/, stop: /--\|/, type: BLOCK_COMMENT
end
```
