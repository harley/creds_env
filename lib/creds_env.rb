# frozen_string_literal: true

require "rails"
require_relative "creds_env/version"

class CredsEnv
  class Error < StandardError; end

  # Your code goes here...

  include Singleton

  def self.load(rails_application)
    # turn credentials that are IN_CAPS to be ENV["IN_CAPS"] env var
    config = rails_application.credentials.config
    config.keys.grep(/[A-Z]/).each do |var|
      ENV[var.to_s] = config[var].to_s
    end
  end
end
