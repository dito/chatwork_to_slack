require 'slack-ruby-client'
require './app.rb'

Slack.configure do |config|
    config.token = ENV.fetch('SLACK_API_TOKEN')
end

run App
