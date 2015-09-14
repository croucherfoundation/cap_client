# require 'concerns/has_application'
# require 'concerns/has_round'

module CapClient
  class Engine < ::Rails::Engine
    isolate_namespace CapClient

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    
    initializer :cap_client_helper do
      ActiveSupport.on_load :action_controller do
        helper CapClientHelper
      end
    end

    # initializer :cap_client_migrations do |app|
    #   unless app.root.to_s.match root.to_s
    #     config.paths["db/migrate"].expanded.each do |expanded_path|
    #       app.config.paths["db/migrate"] << expanded_path
    #     end
    #   end
    # end

  end
end
