namespace :gchat do
  desc "Send message to gchat."
  task :say => :environment do
    OpenProject::gchat::Notifier.say(
      webhook_url: ENV['HOOK'].presence,
      attachments: [ENV["ATTACHMENT"].presence].compact
    )
  end
end
