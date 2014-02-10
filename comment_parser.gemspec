$:.unshift File.expand_path('../lib', __FILE__)
require 'comment_parser/version'

Gem::Specification.new do |s|
  s.authors               = 'alpaca-tc'
  s.date                  = Time.now.strftime('%Y-%m-%d')
  s.email                 = 'alpaca-tc@alpaca.tc'
  s.files                 = `git ls-files`.split("\n")
  s.homepage              = 'https://github.com/alpaca-tc/comment_parser'
  s.license               = 'MIT'
  s.name                  = 'comment_parser'
  s.require_paths         = %w!lib!
  s.required_ruby_version = '>= 2.0.0'
  s.test_files            = `git ls-files -- {spec}/*`.split("\n")
  s.version               = CommentParser::VERSION

  s.summary               = 'an inline comment parser'
  s.description           = 'an inline comment parser for source code'

  # s.add_development_dependency 'rake'
  # s.add_development_dependency 'rspec'
  # s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
end
