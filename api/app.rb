require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'
require 'line/bot'
require './liff_profile'
require './micro_cms'

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
  data = MicroCms.new.get_contents(offset: params[:offset] || 0, limit: params[:limit] || 50)
  json data
end

post '/api/content' do
  autholization = request.env['HTTP_AUTHORIZATION']
  access_token = Hash[*autholization.split(' ')]['Bearer']
  user_info = LiffProfile.new(access_token).get_profile

  id, error_message = MicroCms.new.create_content(user_name: user_info['displayName'], user_picture_url: user_info['pictureUrl'], text: params['text'])

  if id
    data = {
      id: id,
      userName: user_info['displayName'],
      userPictureUrl: user_info['pictureUrl'],
      text: params['text']
    }
    json data
  else
    data = { error_message: error_message }
    status 400
    json data
  end
end
