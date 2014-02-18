# comment\_extractor

[![Gem Version](https://badge.fury.io/rb/comment_extractor.png)](http://badge.fury.io/rb/comment\_extractor)
[![Build Status](https://travis-ci.org/alpaca-tc/comment_extractor.png?branch=v1.0.0)](https://travis-ci.org/alpaca-tc/comment\_parser)
[![Coverage Status](https://coveralls.io/repos/alpaca-tc/comment_extractor/badge.png?branch=v1.0.0)](https://coveralls.io/r/alpaca-tc/comment\_extractor?branch=v1.0.0)

## Description

comment\_extractor extracts the comment out from a source code.

## Installation

CommentExtractor has been tested with ruby 2.1.

```sh
git clone https://github.com/alpaca-tc/comment_extractor
cd comment_extractor
rake install
```

## Usage

### Parser

Given a file path to `Parser.for`, it finds Extractor and returns an instance of self which is initialized by extractor. Getting the comments from file by using it.

```ruby
require 'comment_extractor'

path = 'path/to/file'
if parser = CommentExtractor::Parser.for(path)
  comments = parser.parse
  comemnts.is_a?(CommentExtractor::CodeObjects)

  comment = comments.first
  comment.file  #=> 'path/to/file'
  comment.line  #=> 1
  comment.value #=> 'I am a comment'
end
```

### Extractor

#### You can use Extractor directly.

```ruby
require 'comment_extractor'

file_path = 'path/to/file.rb'
manager = CommentExtractor::ExtractorManager
if extractor = manager.can_extract(file_path)
  content = File.read(file_path)
  comments = extractor.new(content).extract_comments
  comemnts.is_a?(CommentExtractor::CodeObjects)
end

# Other way to find extractor
extractor = manager.find_extractor_by_shebang('#! /usr/local/bin/ruby')
extractor = manager.find_extractor_by_filename('path/to/file.rb')
extractor = manager.find_extractor_by_filetype('ruby')
```

#### How to use extractor of specific filetype.

```ruby
require 'comment_extractor/extractor/d'

content = File.read('path/to/file.d')
comments = CommentExtractor::Extractor::D.new(content).extract_comments
```

### Supported FileTypes

- **Bash / Zsh**
- **C / C++**
- **Class**
- **C#**
- **Clojure**
- **Coffee-Script**
- **D**
- **EmacsLisp**
- **Erlang**
- **Fortran**
- **Go**
- **Haml**
- **Haskell**
- **HTML**
- **Java**
- **JavaScript**
- **Tex**
- **Lua**
- **PHP**
- **Perl**
- **Python**
- **Ruby**
- **SASS**
- **SCSS**
- **SQF**
- **SQL**
- **Scala**

### TODO

- Markdown
- SQS; I can not implement it because I do not know the syntax of sqs.

### Create a new Extractor

If you see something missing from the supported file type, please either file an issue or submit a pull request:)
And I would be glad if I could have you send the new filetype's source code via an issues.

```ruby
# lib/comment_extractor/extractor/file_type.rb
require 'comment_extractor/extractor'

class CommentExtractor::Extractor::FileType < CommentExtractor::Extractor
  include CommentExtractor::Extractor::Concerns::SimpleExtractor

  shebang /ruby$/            # (Optional)
  filename /\.(extention)$/  # (Required)
  filetype 'filetype'        # (Required) file type name. g.c 'ruby', 'python'

  # define_ignore_patterns(*given regexp)

  # define_bracket('"')   #=> define_ignore_patterns(/".*?(?<!\\)"/)
  # define_regexp_bracket #=> define_ignore_patterns(%r!/(?=[^/])!, /(?<!\\)\//)

  # define the rule of comment
  comment start_with: /;+/
  comment start_with: /;--/, end_with: /--\|/, type: BLOCK_COMMENT
end
```
