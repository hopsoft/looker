[![Lines of Code](http://img.shields.io/badge/lines_of_code-52-brightgreen.svg?style=flat)](http://blog.codinghorror.com/the-best-code-is-no-code-at-all/)
[![Code Status](http://img.shields.io/codeclimate/github/hopsoft/looker.svg?style=flat)](https://codeclimate.com/github/hopsoft/looker)
[![Dependency Status](http://img.shields.io/gemnasium/hopsoft/looker.svg?style=flat)](https://gemnasium.com/hopsoft/looker)
[![Build Status](http://img.shields.io/travis/hopsoft/looker.svg?style=flat)](https://travis-ci.org/hopsoft/looker)
[![Coverage Status](https://img.shields.io/coveralls/hopsoft/looker.svg?style=flat)](https://coveralls.io/r/hopsoft/looker?branch=master)
[![Downloads](http://img.shields.io/gem/dt/looker.svg?style=flat)](http://rubygems.org/gems/looker)

# Looker

## Hash based enumerated types (ENUMS)

## Quick Start

```sh
gem install looker
```

```ruby
Looker.add roles: {
    :admin  => 1,
    :reader => 2,
    :writer => 3
  }

# The name (first Hash key) & value is converted
# to an upcase named frozen constant on the Looker module

Looker::ROLES[:admin]  # => 1
Looker::ROLES[1]       # => :admin

Looker::ROLES[:reader] # => 2
Looker::ROLES[2]       # => :reader

Looker::ROLES[:writer] # => 3
Looker::ROLES[3]       # => :writer
```

__NOTE:__ You can perform lookups using both the key & value.

## Multiple Enumerated Types

It's possible to add multiple enumerated types with a single call to `Looker#add`.

```ruby
Looker.add(
  roles: {
    :admin  => 1,
    :reader => 2,
    :writer => 3
  },

  colors: {
    :red    => "ff0000",
    :yellow => "ffff00",
    :blue   => "0000ff"
  }
)

Looker::ROLES[:admin]    # => 1
Looker::ROLES[3]         # => :writer

Looker::COLORS[:red]     # => "ff0000"
Looker::COLORS["ffff00"] # => :yellow
```

## Adding Enumerated Types from YAML

It can be useful to manage enumerated type definitions with a YAML file.

```yaml
# /path/to/enums.yml
roles:
  admin: 1
  reader: 2
  writer: 3

colors:
  red: ff0000
  yellow: ffff00
  blue: 0000ff
```

```ruby
Looker.add YAML.load(File.read("/path/to/enums.yml")

Looker::ROLES["reader"]  # => 2
Looker::ROLES[1]         # => "admin"

Looker::COLORS["yellow"] # => "ffff00"
Looker::COLORS["0000ff"] # => "blue"
```

## ActiveRecord enums

You may find it useful to reuse Looker defined enumerated types as [ActiveRecord enums](http://api.rubyonrails.org/classes/ActiveRecord/Enum.html).

Fortunately this is pretty simple&mdash; just use the `to_h` method on the Looker constant.

```ruby
Looker.add roles: {
  :admin  => 1,
  :reader => 2,
  :writer => 3
}

class User < ActiveRecord::Base
  enum roles: Looker::ROLES.to_h
end
```

