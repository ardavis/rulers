require 'haml'
require 'rulers/file_model'

module Rulers
  class Controller
    include Rulers::Model

    attr_reader :env

    def initialize(env)
      @env = env
    end

    def render(view_name, locals={})
      filename = File.join('app', 'views', controller_name, "#{view_name}.html.haml")
      template = File.read filename

      haml = Haml::Engine.new(template)
      haml.render(Object.new, locals.merge(env: env))
    end

    private

    def instance_variables

    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore(klass)
    end
  end
end