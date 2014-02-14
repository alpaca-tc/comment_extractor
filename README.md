# strip\_comment

[![Gem Version](https://badge.fury.io/rb/comment_extractor.png)](http://badge.fury.io/rb/comment_extractor) [![Build Status](https://travis-ci.org/alpaca-tc/comment_extractor.png?branch=develop)](https://travis-ci.org/alpaca-tc/comment\_parser)

## Description

*Simple tokenizer for taking out only a comment out*

comment\_parser takens out only a comment out from a source code.

## Installation

CommentExtractor has been tested with ruby 2.1.

```sh
git clone https://github.com/alpaca-tc/comment_extractor
cd comment_extractor
rake install
```

## Usage

### Parser

Parser is wrapper around scanners.
When given a file to `Parser.for`, CommentExtractor::Parser returns parser of file given.

```ruby
require 'comment_extractor'

path = 'path/to/file'
if parser = CommentExtractor::Parser.for(path)
  comments = parser.parse
  comment = comments.first
  comemnt.is_a?(CommentExtractor::CodeObject::Comment)
  comment.file  #=> #<CommentExtractor::File:path/to/file>
  comment.line  #=> 1
  comment.value #=> 'I am a comment'
end
```

### Scanner

```ruby
require 'comment_extractor'

file = CommentExtractor::File.new('path/to/file.rb')
if scanner_klass = CommentExtractor::Parser.find_scanner_by_filetype('ruby')
  scanner = scanner_klass.new(file)
  scanner.scan
  p scanner.comments #=> [#<CommentExtractor::CodeObject::Comment:0x007f98cb90c4f8>, ...]
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
# lib/comment_extractor/scanner/new_file_type.rb

class CommentExtractor::Scanner::NewFileType < CommentExtractor::Scanner
  include CommentExtractor::Scanner::Concerns::SimpleScanner

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
