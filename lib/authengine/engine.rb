require 'authengine'
require 'rails'
require 'action_controller'
#require 'application_helper'

module Authengine
  class Engine < Rails::Engine

    # Config defaults
    config.widget_factory_name = "default factory name"
    config.mount_at = '/'
    
    # Load rake tasks
    #rake_tasks do
      #load File.join(File.dirname(__FILE__), 'rails/railties/tasks.rake')
    #end
    
    # Check the gem config
    initializer "check config" do |app|
      # make sure mount_at ends with trailing slash
      config.mount_at += '/'  unless config.mount_at.last == '/'
    end
    
    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    initializer "authengine.application_controller" do |app|
      ActiveSupport.on_load(:action_controller) do
        include AuthenticatedSystem
        include AuthorizedSystem
      end
    end
    
  end
end
