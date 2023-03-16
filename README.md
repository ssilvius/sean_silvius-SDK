# TheOneApi Gem

A quick SDK for the one api for liblab.

## Installation

Install the gem and add to the application's Gemfile by executing:

    `bundle add the_one_api`

If bundler is not being used to manage dependencies, install the gem by executing:

   `gem install the_one_api`

## Usage

This gem provides an SDK for [the one api](https://the-one-api.dev) movie endpoint. It supports pagination options and requires an api key to operate. Please see the [provider's documentation](https://the-one-api.dev/documentation) to obtain an authoration token.

### Configuration

The module can be configured externally or at runtime. For example if being used with rails, create in initializer file and add the following to set defaults for pagination.

```Ruby
    TheOneApi.configure do |opts|
    opts[:limit] = 10
    opts[:page] = 1
    opts[:offset] = 0
    end
```

```Ruby
    one = TheOneApi.new
    one.call(:movie) # returns list of the current released movies.
    one.call(:movie, film: 1) #returns the movie with the id of 1
    one.call(:quote, film: 1, limit: 10) # returns 10 quotes from the film with id of 1
```

### Testing

To run tests, from the project folder, `rspec`.

Rspec is used to test the module. Please refer to their docs on [usage](https://rspec.info/)

### Documentation

Run `yardoc` from the project folder to generate the documentation. The documentation will be generated in the doc/ directory.

**Serve the documentation:** Run yard server to start a web server that serves the documentation. You can view the documentation by visiting <http://localhost:8808/> in your web browser.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/ssilvius/the_one_api>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ssilvius/the_one_api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TheOneApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ssilvius/the_one_api/blob/master/CODE_OF_CONDUCT.md).
