require "rulers/version"
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'
require 'rulers/file_model'

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, { 'Content-Type' => 'text/html' }, []]
      end

      if env['PATH_INFO'] == '/'
        # env['PATH_INFO'] = '/quotes/a_quote'
        text = File.read('public/index.html')
      else
        klass, action = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(action)
      end

      [200, { 'Content-Type' => 'text/html' }, [text]]
    end
  end
end
