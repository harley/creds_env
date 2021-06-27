# CredsEnv

`creds_env` aims to:

- help you embrace Rails 6+ credentials management system (if you don't think it's better than sharing `.env.*` files , see if this [this great article](https://betterprogramming.pub/how-to-migrate-environment-variables-env-to-rails-credentials-d3f48164f7c8?gi=71f507360259) has a good point or two).
- maintain dotenv style coding with `ENV["SOME_KEY"]` because it's shorter (than `Rails.application.credentials`) and familiar with developers of most frameworks.

## Installation

Run `bundle add creds_env` to the gem to your Gemfile.

And then execute:

    $ bundle install

Check past versions at https://rubygems.org/gems/creds_env

## Usage

Any ALL_CAPS key names in your encrpted credentials will be copied over as ENV vars.

For example:

    bin/rails credentials:edit

Add DATABASE_URL like this:

    ```yaml
    DATABASE_URL: postgres://localhost:5432/example_development
    ```

Check in `bin/rails console`:

    ```rb
    puts ENV["DATABASE_URL"] # => postgres://localhost:5432/example_development
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/harley/creds_env. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/creds_env/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CredsEnv project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/creds_env/blob/main/CODE_OF_CONDUCT.md).
