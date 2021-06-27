# frozen_string_literal: true

require_relative "lib/creds_env/version"

Gem::Specification.new do |spec|
  spec.name = "creds_env"
  spec.version = CredsEnv::VERSION
  spec.authors = ["Harley Trung"]
  spec.email = ["harley@coderpush.com"]

  spec.summary = "Set ENV variables in your Rails 6+ credentials and use them as usual."
  spec.description = "Combine the benefits of the widely used ENV vars approach with the encrypted credentials of Rails 6+. \
                      \ Share a single key with your team to unlock the version-control changes of all API keys."
  spec.homepage = "https://github.com/harley/creds_env"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/harley/creds_env"
  spec.metadata["changelog_uri"] = "https://github.com/harley/creds_env/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "> 6.0"

  spec.add_development_dependency "rspec", "~> 3.10.0"
  spec.add_development_dependency "standard", "~> 1.1.2"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
