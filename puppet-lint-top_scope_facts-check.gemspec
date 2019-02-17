Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-top_scope_facts-check'
  spec.version     = '0.0.1'
  spec.homepage    = 'https://github.com/mmckinst/puppet-lint-top_scope_facts-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Mark McKinstry'
  spec.email       = 'mmckinst@umich.edu'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'Check for top scope facts and convert them to the facts hash'

  spec.description = <<-EOF
  A puppet-lint plugin to check you are not using top scope fact variables like
  $::operatingsystem. You should use the $facts hash like
  $facts['operatingsystem'] instead.
  EOF

  spec.add_dependency             'puppet-lint', '~> 2.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-json_expectations'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
end
