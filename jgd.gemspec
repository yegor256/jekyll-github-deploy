# coding: utf-8
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '2.2.2'
  s.required_ruby_version = '>= 1.9.3'
  s.name = 'jgd'
  s.version = '1.2'
  s.license = 'MIT'
  s.summary = "Jekyll Github Deploy"
  s.description = "Automated deployment of your Jekyll blog to Github Pages"
  s.authors = ["Yegor Bugayenko"]
  s.email = 'yegor@tpc2.com'
  s.homepage = 'http://github.com/yegor256/jekyll-github-deploy'
  s.files = `git ls-files`.split($/)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE.txt]
  s.add_runtime_dependency('trollop', '2.0')
  s.add_runtime_dependency('jekyll', '>=1.5.1')
end
