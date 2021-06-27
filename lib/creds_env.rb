# frozen_string_literal: true

require "rails"
require_relative "creds_env/version"

module CredsEnv
  class Error < StandardError; end

  def self.load(rails_application = nil)
    application = rails_application || Rails.application
    # turn credentials that are IN_CAPS to be ENV["IN_CAPS"] env var
    config = application.credentials.config
    config.keys.grep(/[A-Z]/).each do |var|
      ENV[var.to_s] = config[var].to_s
    end
  end
end
