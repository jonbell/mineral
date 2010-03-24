require 'active_support/ordered_hash'
require 'mineral/response'

module Mineral
  module Rack
    class Mineral

      cattr_accessor :mineral_paths
      self.mineral_paths = ["#{::Rails.root}/app/mineral"]
      cattr_accessor :requested_minerals

      def self.minerals
        matcher = /#{Regexp.escape('/app/mineral/')}(.*)\.rb\Z/
        mineral_glob = mineral_paths.map{ |base| "#{base}/**/*.rb" }
        all_minerals = {}

        mineral_glob.each do |glob|
          Dir[glob].sort.map do |file|
            file = file.match(matcher)[1]
            all_minerals[file.camelize] = file
          end
        end

        load_list = requested_minerals || all_minerals.keys

        load_list.map do |requested_mineral|
          if mineral = all_minerals[requested_mineral]
            require_dependency 'app/mineral/' + mineral
            requested_mineral.constantize
          end
        end.compact
      end

      def initialize(app)
        @app = app
        @minerals = self.class.minerals.clone
        freeze
      end

      def call(env)
        request = ::Rack::Request.new(env)
        @minerals.each do |app|
          if app.methods.include?(request.request_method) && matcher = app.regex.match(request.path_info)
            args = []
            1.step(matcher.size - 1){|group| args << matcher[group]}
            result = app.send(request.request_method.downcase, request, *args)
            if result.is_a?(Array)
              return result
            elsif result.is_a?(::Mineral::Response)
              return result.to_rack
            end
          end
        end
        @app.call(env)
      end
    end
  end
end
