[![Build Status](https://travis-ci.org/mmckinst/puppet-lint-top_scope_facts-check.svg?branch=master)](https://travis-ci.org/mmckinst/puppet-lint-top_scope_facts-check)

A puppet-lint plugin to check you are not using top scope fact variables like
`$::operatingsystem`. You should use the $facts hash like
`$facts['operatingsystem']` instead.

## Installing

### From the command line

```shell
$ gem install puppet-lint-top_scope_facts-check
```

### In a Gemfile

```ruby
gem 'puppet-lint-top_scope_facts-check', :require => false
```

## Checks

#### What you have done

```puppet
$service_name = $::operatingsystem {
  'CentOS' => 'httpd',
  'Debian' => 'apache2',
}
```

#### What you should have done

```puppet
$service_name = $facts['operatingsystem'] {
  'CentOS' => 'httpd',
  'Debian' => 'apache2',
}
```

#### Disabling the check

To disable this check, you can add `--no-top_scope_facts` to your puppet-lint
command line.

```shell
$ puppet-lint --no-top_scope_facts path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should
insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_top_scope_facts')
```

## Limitations

* It only finds facts using the top-scope: ie it will find `$::operatingsystem`
  but not `$operatingsystem`
* If you have legit, non-fact top scope variables, it will incorrectly find
  them.

## License

```
Copyright 2016 Mark McKinstry

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
