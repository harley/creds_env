# frozen_string_literal: true

require "creds_env"
require_relative "support/credentials_helper"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Restore the state of ENV after each spec
  config.before { @env_keys = ENV.keys }
  config.after { ENV.delete_if { |k, _v| !@env_keys.include?(k) } }
end
