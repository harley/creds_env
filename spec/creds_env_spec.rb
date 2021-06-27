# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"
require "action_controller/railtie"

RSpec.describe CredsEnv do
  before do
    class RailsTestApp < Rails::Application
      config.logger = Logger.new(nil)
      config.eager_load = false # avoid warning
      config.require_master_key = true
    end

    RailsTestApp.initialize!

    CredentialsHelper.update_credentials_yml_enc({})
  end

  after do
    %i[RailsTestApp].each do |const|
      Object.send(:remove_const, const)
    end

    Rails.application = nil
  end

  let(:sample_creds) do
    {
      secret_key_base: "abc123",
      DATABASE_URL: "postgres://localhost:5432/example_development",
      AWS_ACCESS_KEY_ID: "aws123",
      AWS_SECRET_ACCESS_KEY: "aws123",
    }
  end

  context "check Rails app setup" do
    it "has a version number" do
      expect(CredsEnv::VERSION).not_to be nil
    end

    it "ENV['RAILS_ENV'] exists" do
      expect(ENV["RAILS_ENV"]).to eq "test"
    end

    it "sets up Rails creds correctly" do
      CredentialsHelper.update_credentials_yml_enc(sample_creds)
      expect(Rails.application.credentials.read).to eq sample_creds.to_yaml
    end
  end

  describe ".load" do
    before do
      CredentialsHelper.update_credentials_yml_enc(sample_creds)
      # manually loading before
      CredsEnv.load(Rails.application)
    end

    it "sets variables like DATABASE_URL" do
      expect(ENV["DATABASE_URL"]).to eq sample_creds.dig(:DATABASE_URL)
      expect(ENV["AWS_ACCESS_KEY_ID"]).to eq sample_creds.dig(:AWS_ACCESS_KEY_ID)
      expect(ENV["AWS_SECRET_ACCESS_KEY"]).to eq sample_creds.dig(:AWS_SECRET_ACCESS_KEY)
    end

    it "ignores variables like secret_key_base" do
      expect(ENV["secret_key_base"]).to eq nil
    end
  end
end
