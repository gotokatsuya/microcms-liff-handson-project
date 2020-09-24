require 'net/http'
require 'uri'
require 'json'

class MicroCms
  # get contents
  # @params [Integer] offset
  # @params [Integer] limit
  def get_contents(offset: 0, limit: 50)
    uri = URI.parse("https://microcms-liff.microcms.io/api/v1/posts")
    uri.query = URI.encode_www_form({
      offset: offset,
      limit: limit,
      fields: %i[id userName userPictureUrl text].join(',')
    })
    request = Net::HTTP::Get.new(uri)
    request["X-Api-Key"] = ENV["MICRO_CMS_READ_API_KEY"]

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    JSON.parse(response.body)['contents']
  end

  # create new content
  #
  # @param [String] text
  # @param [String] user_name
  # @param [String] user_picture_url
  # @return [Array<String, nil>] when success [id, nil], when failed [nil, error_message]
  def create_content(text:, user_name:, user_picture_url:)
    uri = URI.parse("https://microcms-liff.microcms.io/api/v1/posts")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["X-Write-Api-Key"] = ENV["MICRO_CMS_WRITE_API_KEY"]

    request.body = JSON.dump({
      "text" => text,
      "userName" => user_name,
      "userPictureUrl" => user_picture_url
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    [JSON.parse(response.body)['id'], JSON.parse(response.body)['message']]
  end
end
