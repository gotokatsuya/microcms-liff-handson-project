require 'net/http'
require 'uri'

class LiffProfile
  def initialize(access_token)
    @access_token = access_token
  end

  def get_profile
    uri = URI.parse("https://api.line.me/v2/profile")
    request = Net::HTTP::Get.new(uri)

    request["Authorization"] = "Bearer #{@access_token}"

    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.use_ssl = true
      http.request(request)
    end

    JSON.parse(response.body)
  end
end
