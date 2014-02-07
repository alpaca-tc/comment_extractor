strip\_comment is simple strip code utility tool.

## Install

[![Build Status](https://travis-ci.org/alpaca-tc/strip_comment.png?branch=develop)](https://travis-ci.org/alpaca-tc/strip_comment)

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

### Create new Scanner

If you wanted to create new scanner for new file type, you send me Pull-Request.

1. Create `StripComment::Scanner::#{FileTypeName}` to `strip_comment/scanner/#{file_type_name}.rb`
2. Define `#scan` method.

Syntax Sample

```ruby
class StripComment::Scanner::Coffee < StripComment::Scanner
  # (required) Regexp to match extname for new file type
  filename /\.coffee$/

  # (required) file type name
  filetype 'coffee'

  # Shebang of new file type
  # g.u `#! /usr/bin/coffee` is matched by /.*\/coffee/
  shebang /.*\/coffee/

  # (Development feature) Does not register self to Parser
  disable!

  def scan
    scanner = build_scanner # => @scanner ||= StringScanner.new(self.content)

    until scanner.eos?
      case
      when scanner.scan(StripComment::Scanner::REGEXP[:BREAK]), scanner.scan(%r!^\s*$!)
        next
      when scanner.scan(%r!^\s*#!)
        scan_singleline_comment
      when scanner.scan(%r!^\s*[^#]+!)
        next
      else
        raise_report # => Raise error message
      end
    end

    self.comments # => returns @comments
  end

  def scan_singleline_comment
    scanner = build_scanner
    comment = scanner.scan(/^\s*.*$/).strip

    # #add_comment(line_number, comment_message) appends new comment object to @comments
    # .current_line returns scanner's current line
    self.add_comment(self.current_line, comment)
  end
end
```

You can test code by rspec. [Check out here](https://github.com/alpaca-tc/strip_comment/blob/develop/spec/strip_comment/scanner/ruby_spec.rb)

## TODO

- [ ] Renaming strip\_comment to the suitable name
- [ ] Parallel processing of parser
- [ ] Creating Scanner of more file types
