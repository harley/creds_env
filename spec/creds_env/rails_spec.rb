require "spec_helper"
require "rails"
require "creds_env/rails"

RSpec.describe CredsEnv::Railtie do
  context "before_configuration hook" do
    before do
      Rails.env = "test"
      Rails.application = double(:application)
    end
    after do
      Rails.application = nil
    end
    it "calls #load" do
      expect(CredsEnv::Railtie.instance).to receive(:load)
      ActiveSupport.run_load_hooks(:before_configuration)
    end
  end

  context "autoloading" do
    let(:sample_creds) do
      {
        secret_key_base: "abc123",
        DATABASE_URL: "postgres://localhost:5432/example_development",
        AWS_ACCESS_KEY_ID: "aws123",
        AWS_SECRET_ACCESS_KEY: "aws123"
      }
    end

    before do
      class RailsTestApp < Rails::Application
        config.logger = Logger.new(nil)
        config.eager_load = false # avoid warning
        config.require_master_key = true
      end

      RailsTestApp.initialize!
      CredentialsHelper.update_credentials_yml_enc(sample_creds)
    end

    after do
      %i[RailsTestApp].each do |const|
        Object.send(:remove_const, const)
      end
      Rails.application = nil
    end

    it "sets variables like DATABASE_URL; ignores secret_key_base" do
      expect(ENV["DATABASE_URL"]).to eq sample_creds.dig(:DATABASE_URL)
      expect(ENV["AWS_ACCESS_KEY_ID"]).to eq sample_creds.dig(:AWS_ACCESS_KEY_ID)
      expect(ENV["AWS_SECRET_ACCESS_KEY"]).to eq sample_creds.dig(:AWS_SECRET_ACCESS_KEY)
    end

    it "does not set variables like secret_key_base" do
      expect(ENV["secret_key_base"]).to eq nil
    end
  end
end
