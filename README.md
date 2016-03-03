# Hangman

[![Code Climate](https://codeclimate.com/github/andela-fsenjobi/femis_hangman/badges/gpa.svg)](https://codeclimate.com/github/andela-fsenjobi/femis_hangman) [![Coverage Status](https://coveralls.io/repos/github/andela-fsenjobi/femis_hangman/badge.svg?branch=master)](https://coveralls.io/github/andela-fsenjobi/femis_hangman?branch=master)

Hangman is a game of guesses. A word is randomly selected from a predefined list and you will be required to guess what it is. You will be told how long the word is and how many chances you have got. You have to guess right or get hanged!

The game has three levels:

1) Beginner       |  4-8 words          |  8 turns

2) Intermediate   |  9-12 words         |  9 turns

3) Advanced       |  Above 12           |  10 turns

The game also has an option of either a boring or graphic output. The boring feedback type looks like `You are dead. The word is unforgatable` while the graphic feedback looks something like a match stick drawing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'femis_hangman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install femis_hangman

## Usage
Download this [Dictionary](https://drive.google.com/open?id=0B1C3woZnW_mZQjZpUWlpNEZlTk0) or any dictionary of your choise and save it as 'dictionary.txt' in the folder you will be playing from

###From IRB
After installing the gem hangman, run `require 'hangman'` from your IRB console. The game instruction is then displayed

###From Command Line
Run femis_hangman

###Game Instructions

To play a new game: Press 'p' or 'play'

To load a saved game: Press 'l' or 'load'

To show instructions: Press 'i' or 'instructions'

To quit Hangman: Press 'q' or 'quit'

####While playing,
You can quit with ':q' or 'quit'. (You can save before exiting)

Display used letters with ':h' or 'history'

####Loading a saved game
After loading a game with 'l' or 'load', a list of saved games will be displayed. Press the corresponding ID to load your game

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andela-fsenjobi/femis_hangman. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

