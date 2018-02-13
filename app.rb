require 'sinatra'
require 'json'
require './app/models/webhook'

class App < Sinatra::Base
  post "/#{ENV.fetch('ENTRY_POINT')}" do
    Webhook.new(payload: payload).hook
    [204]
  end

  private

  def payload
    JSON.parse(request.body.read)
  rescue JSON::ParserError
    {}
  end
end
