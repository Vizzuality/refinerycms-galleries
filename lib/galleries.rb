require 'refinery'

module Refinery
  module Galleries
    class Engine < Rails::Engine
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "galleries"
          plugin.menu_match = /^\/?(admin|refinery)\/(gallery\_entries|galleries)/
          plugin.activity = {:class => Gallery,
            :title => 'name'
          }
        end
      end
    end
  end
end
