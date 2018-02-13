class Webhook
  attr_reader :payload

  def initialize(payload:)
    @payload = payload
  end

  def post
    client.chat_postMessage(channel: channel, text: text)
  end

  private

  def client
    @client ||= Slack::Web::Client.new
  end

  def text
    payload['webhook_event']['body']
  end

  def channel
    channel_mapping.detect(chatwork_room_id: chatwork_room_id)
  end

  def channel_mapping
    YAML.load_file(ENV.fetch('CHANNELS_MAPPING_FILE_PATH'))
  end

  def chatwork_room_id
    payload['webhook_event']['room_id']
  end
end
