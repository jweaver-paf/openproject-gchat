# OpenProject gchat Plugin

Provides a very rudimentary gchat integration.
All it does right now is post updates in configured gchat channels when ever a
work package or a wiki page is updated.

## Installation

Please refer to the [documentation](https://docs.openproject.org/installation-and-operations/configuration/plugins/#adding-plugins-debrpm-packages) to see how to install plugins in general.

Do as shown in the documentation with the following custom Gemfile:

```
group :opf_plugins do
  gem "openproject-gchat", git: "https://github.com/opf/openproject-gchat.git", branch: "dev"
end
```

## Configuration

Once the plugin is installed you can configure it under [/settings/plugin/openproject_gchat](http://localhost:3000/settings/plugin/openproject_gchat).![global-gchat-settings](docs/global-gchat-settings.png)

There you configure the gchat [incoming webhook URL](https://api.gchat.com/messaging/webhooks) you want to use by default.

You can customize this on a per-project basis using the project settings of each project.

![project-gchat-settings](docs/project-gchat-settings.png)

You can see the *gchat Webhook URL* setting right after the project name. Insert your URL there.
If none is set the global defined before is used.

## Issue Tracker

https://community.openproject.org/projects/gchat/work_packages
