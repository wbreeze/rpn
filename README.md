# RPN

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rpn_dclovell'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rpn_dclovell

## Usage

The gem installs a command, `rpn`

```bash
> gem install rpn_dclovell
> rpn
rpn=>
```

The command presents a prompt for input of expressions in prefix notation.

 - Type 'h' or 'help' to get a summary of current capabilities.
 - Type 'q' or 'bye', or send EOF (`^d`, `ctrl-d`) to exit.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wbreeze/rpn.
