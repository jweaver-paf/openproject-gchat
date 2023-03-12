module OpenProject
  module gchat
    require "open_project/gchat/engine"

    class << self
      def webhook_url_label
        "gchat Webhook URL"
      end

      def default_webhook_url
        settings["webhook_url"]
      end

      def enable!
        set_enabled true
      end

      def disable!
        set_enabled false
      end

      def set_enabled(value)
        Setting.plugin_openproject_gchat = settings.merge "enabled" => !!value
      end

      def enabled?
        value = settings["enabled"]

        case value
        when true, false
          value
        when nil
          false
        else
          value.to_s.to_bool
        end
      end

      def disabled?
        !enabled?
      end

      def settings
        Setting.plugin_openproject_gchat
      end

      def configured?
        default_webhook_url.present?
      end

      def project_custom_field_params
        {
          name: webhook_url_label,
          type: 'ProjectCustomField',
          field_format: 'string'
        }
      end

      def project_custom_field
        CustomField.find_or_create_by project_custom_field_params
      end
    end
  end
end
