[![Build Status](https://travis-ci.org/mmckinst/puppet-lint-top_scope_facts-check.svg?branch=master)](https://travis-ci.org/mmckinst/puppet-lint-top_scope_facts-check)
[![Gem](https://img.shields.io/gem/v/puppet-lint-top_scope_facts-check.svg?maxAge=2592000)](https://rubygems.org/gems/puppet-lint-top_scope_facts-check)

A puppet-lint plugin to check you are not using top scope fact variables like
`$::operatingsystem`. You should use the $facts hash like
`$facts['operatingsystem']` instead.

## Overview

In puppet 2.x facts were top scope variables and accessed as `$operatingsystem`
or `$::operatingsystem`, the
[latter being far more common](https://docs.puppet.com/puppet/3.8/reference/lang_facts_and_builtin_vars.html#historical-note-about-)
especially because the
[linter enforces that convention](http://puppet-lint.com/checks/variable_scope/).

Puppet 3.5 added a `$facts` hash to access facts like
`$facts['operatingsystem']`. This works if you set `trusted_node_data = true`
but it was
[not enabled by default](https://docs.puppet.com/puppet/3.5/reference/release_notes.html#global-facts-hash). Puppet
4 has it enabled by default.

This puppet-lint plugin will help find facts referenced as top scope variables
and replace them with the `$facts` hash to improve readability of code. Its only
useful if you're running puppet 3.5 to 3.8 with trusted_node_data enabled, or if
you're running puppet 4.

## Limitations

* It only finds facts using the top-scope: ie it will find `$::operatingsystem`
  but not `$operatingsystem`.
* It assumes all top scope variables are facts. If you have top scope variables
  that aren't facts you should configure the
  [linter to ignore them](https://github.com/mmckinst/puppet-lint-top_scope_facts-check#configuring-the-check).


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

#### Configuring the check

You can whitelist top scope variables to ignore via the Rake task. You should
insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.top_scope_variables = ['location', 'role']
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
