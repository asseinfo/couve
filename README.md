# Couve - Generate Human Readable CodeClimate Test Reporter

Couve is a Ruby gem that aims to simplify the generation of human-readable reports for the CodeClimate test-reporter gem. With Couve, you can quickly and easily generate insightful reports based on the test coverage data in a human-friendly format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'couve'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install couve

## Usage

1. Install the `couve` gem.

```ruby
gem install couve
```

2. Run the following command in your terminal, providing the path to your JSON coverage file and the desired output HTML file.

```
$ couve path/to/coverage.json path/to/output.html
```

Couve will process the coverage data and generate a human-readable HTML report, providing insights into your project's test coverage.

## Development

To contribute to Couve's development, follow these steps:

1. Clone the repository from GitHub:

```
$ git clone https://github.com/asseinfo/couve.git
```

2. Install the gem dependencies by running:

```
$ bin/setup
```

3. Run the tests to ensure everything is set up correctly:

```
$ rake spec
```

4. You can also use the interactive prompt to experiment with the code:

```
$ bin/console
```

## Contributing

We welcome bug reports and pull requests from the community. If you encounter any issues with Couve or have suggestions for improvements, please open an issue on [GitHub](https://github.com/asseinfo/couve) to let us know.

If you'd like to contribute directly, please follow these steps:

1. Fork the repository on GitHub.

2. Create a new branch from the `main` branch.

3. Make your changes and commit them with descriptive commit messages.

4. Push your changes to your fork.

5. Submit a pull request to the `main` branch of the original repository.

We appreciate your contributions and will review and merge pull requests as appropriate.

## License
Couve is released under the [MIT License](https://opensource.org/licenses/MIT), which allows you to use, modify, and distribute the gem freely. See the LICENSE file for more details.
