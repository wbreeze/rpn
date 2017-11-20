[![Build Status](https://travis-ci.org/wbreeze/rpn.svg?branch=master)](https://travis-ci.org/wbreeze/rpn)
[![Maintainability](https://api.codeclimate.com/v1/badges/3c33f1e12008be62024e/maintainability)](https://codeclimate.com/github/wbreeze/rpn/maintainability)

# RPN

A command-line reverse polish notation (RPN) calculator written in Ruby

## Installation

This gem is not published. In order to run it, you will need to clone
this repository as if you were going to work on it. Here are the steps
to run the program, assuming that you already have installed
[Ruby](https://www.ruby-lang.org/en/documentation/installation/),
[RubyGems](https://rubygems.org/pages/download),
[Bundler](http://bundler.io/), and
[git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

```bash
> git clone git@github.com:wbreeze/rpn.git
> cd rpn
> bundle install
> rake install
> rpn
```

## Usage

The gem installs a command, `rpn`

```bash
> rpn

  Welcome. Type "q" to quit, "h" for help.
  I always wait politely for you to press the enter key.

rpn=>
```

The command presents a prompt for input of expressions in prefix notation.

 - Type 'h' or 'help' to get a summary of current capabilities.
 - Type 'q' or 'bye', or send EOF (`^d` or `Ctrl-d`) to exit.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Implementation notes

The implementation follows a model - view - controller design.
The view incorporates a lexical analyzer that produces tokens.
The controller and model interpret the tokens for program control and
computation.

- The `Token` class provides transition tokens for computation and
program control. It includes token factory methods and token type-check
methods.

- The `Lexer` class provides a `lex` method for converting a sentence into
an array of tokens.

- The `TerminalInteractor` class provides methods for interaction on a terminal.
It uses an instance of `Lexer` to convert input and return it as token lists.

- The `Calculator` class interprets `number` and `operator` tokens to implement
a stack-based interpreter. It pushes operands. Given an operator, it
combines operands using the specified operation and pushes the result.

- The `CliController` class uses an instance of `TerminalInteractor` to
drive input and response. It uses an instance of `Calculator` to provide
the key computational function. It detects errors and communicates them
through the `TerminalInteractor`.

#### Expanding

It is relatively simple to add operators by allowing them in the `Lexer` and
recognizing them in the `Calculator`.  With growth in the number of
recognized operators will come growth in the `process_operator` method of
the `Calculator` class. At some point, a table lookup might begin to look
worthwhile and attractive.

The `stack_check` method in `Calculator`
checks for sufficient operands before attempting any operation.
Adding an operator that requires other than two operands will require a
change to that method.
That change might also provide motivation for refactoring with table lookup.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wbreeze/rpn.
