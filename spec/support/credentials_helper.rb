module CredentialsHelper
  def self.update_credentials_yml_enc(conf)
    Rails.application.credentials.change do |path|
      File.open(path, "w") { |f| f.write(conf.to_yaml) }
    end
  end
end
