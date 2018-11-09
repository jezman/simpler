require_relative 'renderer/html_renderer.rb'
require_relative 'renderer/plain_renderer.rb'
require_relative 'renderer/json_renderer.rb'

module Simpler
  class View
    def initialize(env)
      detect_renderer(env)
    end

    def render(binding)
      @renderer.render(binding)
    end

    private

    def detect_renderer(env)
      @renderer = case env['simpler.template'].keys.first
                  when :plain then PlainRenderer.new(env)
                  when :json then JSONRenderer.new(env)
                  else
                    HtmlRenderer.new(env)
                  end
    end
  end
end
