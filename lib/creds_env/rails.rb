require "creds_env"
require "rails"

module CredsEnv
  # CredsEnv Railtie for using CredsEnv to load environment from Rails encrypted credentials
  class Railtie < Rails::Railtie
    # Public: Load CredsEnv
    #
    # This will get called during the `before_configuration` callback, but you
    # can manually call `CredsEnv::Railtie.load` if you needed it sooner.
    def load
      CredsEnv.load
    end

    # Rails uses `#method_missing` to delegate all class methods to the
    # instance, which means `Kernel#load` gets called here. We don't want that.
    def self.load
      instance.load
    end

    private

    config.before_configuration { load }
  end
end
