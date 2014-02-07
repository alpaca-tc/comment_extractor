strip\_comment is simple strip code utility tool.

## Install

```sh
git clone https://github.com/alpaca-tc/strip_comment
cd strip_comment
rake install
```

## Usage

```ruby
require 'strip_comment'

root_path = '/path/to/strip_comment'
stripper = StripComment::Stripper.new(root_path: root_path)

stripper.comments.each do |comment_object|
  puts "#{File.expand_path(comment_object.file.path, '\~')}#{comment_object.line} [#{comment_object.value}]"
end

# => /Users/alpaca-tc/projects/strip_comment/lib/strip_comment/encoding.rb15 [When content is UTF-8]
# ...
```

### Scanner

```ruby
require 'strip_comment'

path = '/path/to/file'
file = StripComment::FileObject.new(path)
parser = StripComment::Parser.for(file)
parser.scan
parser.comments # => [StripComment::CodeObject::Comment, ...]
```

## Supported Languages

- C
- C++
- C#
- Java
- Javascript
- Scala
- CSS
- SASS
- SCSS
- Ruby

## TODO

- [ ] Renaming strip\_comment to the suitable name
- [ ] Parallel processing of parser
- [ ] Creating Scanner of more file types
