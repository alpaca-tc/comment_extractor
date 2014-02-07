$:.unshift File.expand_path('../lib', __FILE__)
require 'strip_comment/version'

Gem::Specification.new do |s|
  s.authors               = 'alpaca-tc'
  s.date                  = Time.now.strftime('%Y-%m-%d')
  s.email                 = 'alpaca-tc@alpaca.tc'
  s.files                 = `git ls-files`.split("\n")
  s.homepage              = 'https://github.com/alpaca-tc/strip_comment'
  s.license               = 'MIT'
  s.name                  = 'strip_comment'
  s.require_paths         = %w!lib!
  s.required_ruby_version = '>= 2.0.0'
  s.test_files            = `git ls-files -- {spec}/*`.split("\n")
  s.version               = StripComment::VERSION

  s.summary               = 'an inline comment scanner'
  s.description           = 'an inline comment scanner for source code'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  # s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
end
