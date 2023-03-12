# Prevent load-order problems in case openproject-plugins is listed after a plugin in the Gemfile
# or not at all
require 'open_project/plugins'

module OpenProject::gchat
  class Engine < ::Rails::Engine
    engine_name :openproject_gchat

    include OpenProject::Plugins::ActsAsOpEngine

    register(
      'openproject-gchat',
      author_url: 'https://www.openproject.org',
      settings: {
        default: {
          "enabled" => true,
          "webhook_url" => ''
        },
        partial: 'settings/gchat',
        menu_item: :gchat_settings
      }
    ) do
      menu :admin_menu,
           :gchat_settings,
           { controller: '/admin/settings', action: :show_plugin, id: :openproject_gchat },
           caption: :label_gchat_plugin,
           icon: 'icon2 icon-gchat',
           if: ->(*) { User.current.admin? && ::OpenProject::gchat.enabled? }
    end

    config.to_prepare do
      require 'open_project/gchat/hook_listener'
    end
  end
end
