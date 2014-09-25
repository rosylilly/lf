# lf

__lf__ is a lightweight command-line LTSV processor.

## Installation

Install it yourself as:

    $ gem install lf

## Usage

```
$ lf -h
Usage: lf [options] <filters ...> [file]
    -r, --require FILE               Require a file
    -c, --[no-]color                 Colored output
    -f, --format FORMAT              Choose a format(ltsv, table)
    -b, --[no-]buffered              Flush the output after each LTSV row
    -h, --help                       Show this message
    -v, --version                    Show version
```

### Input

Specify LTSV file path:

```
$ lf example.ltsv
```

Or input via pipe:

```
$ tail -f example.ltsv | lf
```

### Filters

You can set filters to lf: `filter-name:args`

```
$ lf label:tag1,foo example.ltsv
tag1:test	foo:bar
$ lf label:tag1 example.ltsv
tag1:test
```

#### Label filter

`label:select labels(comma separated)`

```
$ lf label:tag1,foo example.ltsv
tag1:test	foo:bar
tag1:test	foo:baz
$ lf label:tag1 example.ltsv
tag1:test
tag1:test
```

#### Ignore filter

`ignore:ignore labels(comma separated)`

```
$ lf ignore:tag1 example.ltsv
foo:bar	test:key	long:long long long message	long long long label:short
foo:baz	test:key	long:long long long message	long long long label:short
```

#### Equal filter

`equal:label:value`

```
$ lf eq:foo:bar example.ltsv
tag1:test	foo:bar	test:key	long:long long long message	long long long label:short
```

#### Regexp filter

`regexp:label:regexp`

```
$ lf reg:foo:r$ example.ltsv
tag1:test	foo:bar	test:key	long:long long long message	long long long label:short
```

#### Customu filter

Make your custom filters:

```ruby
# custom-filter.rb
class StatusCode < Lf::Filter
	filter_alias :status

  def initialize(status_code)
    @status_code = status_code.to_i
  end

  def apply(row)
		row[:status].to_i == @status_code ? row : nil
  end
end
```

```
$ lf --require custom-filter.rb status:200 nginx.log
```


## Contributing

1. Fork it ( https://github.com/rosylilly/lf/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
