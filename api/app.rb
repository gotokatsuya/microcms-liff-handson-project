require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require 'line/bot'

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_id = ENV["LINE_CHANNEL_ID"]
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

post '/api/linebot/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  events.each do |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        message = {
          type: 'text',
          text: event.message['text']
        }
        client.reply_message(event['replyToken'], message)
      end
    end
  end

  # Don't forget to return a successful response
  "OK"
end

# コンテンツ一覧の取得
get '/api/content' do
  data = [
    {
      id: "1",
      userName: "Katsuya Goto",
      userPictureUrl: "Katsuya Goto",
      text: "Hello, I am Katsuya Goto"
    },
    {
      id: "2",
      userName: "Katsuya Goto",
      userPictureUrl: "Katsuya Goto",
      text: "Hello, I am Katsuya Goto"
    },
    {
      id: "3",
      userName: "Katsuya Goto",
      userPictureUrl: "Katsuya Goto",
      text: "Hello, I am Katsuya Goto"
    }
  ]
  json data
end

post '/api/content' do
  data = {
    id: "1",
    userName: "Katsuya Goto",
    userPictureUrl: "Katsuya Goto",
    text: "Hello, I am Katsuya Goto"
  }
  json data
end
