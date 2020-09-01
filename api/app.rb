require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/json'

# コンテンツ一覧の取得
get '/api/contents' do
  data = [
    {
      id: 1,
      contentType: "text",
      content: "It's a sunny day."
    },
    {
      id: 2,
      contentType: "text",
      content: "It's a sunny day."
    },
  ]
  json data
end
