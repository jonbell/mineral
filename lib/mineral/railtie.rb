require 'mineral'

module Mineral
  class Railtie < Rails::Railtie
    initializer 'mineral.register_middleware' do |app|
      app.config.middleware.insert_before ::ActionDispatch::Flash, Mineral::Rack::Mineral
    end
  end
end 