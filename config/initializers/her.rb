require 'settings'
require 'faraday_middleware'
require 'her'
require 'her/middleware/json_api_parser'

api_url = ENV['APPL_API_URL'] || "#{Settings.cap.protocol}://#{Settings.cap.api_host}:#{Settings.cap.api_port}"

CAP = Her::API.new
CAP.setup url: api_url do |c|
  # Request
  c.use FaradayMiddleware::EncodeJson
  # Response
  c.use Her::Middleware::JsonApiParser
  c.use Faraday::Adapter::NetHttp
end
