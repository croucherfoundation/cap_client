require 'settings'
require 'paginated_her'

Settings.cap ||= {}
Settings.cap[:protocol] ||= 'http'
Settings.cap[:api_host] ||= Settings.cap[:host] || 'localhost'
Settings.cap[:api_port] ||= Settings.cap[:port] || 8006

CAP = Her::API.new
CAP.setup url: "#{Settings.cap.protocol}://#{Settings.cap.api_host}:#{Settings.cap.api_port}" do |c|
  c.use Faraday::Request::UrlEncoded
  c.use PaginatedHer::Middleware::Parser
  c.use Faraday::Adapter::NetHttp
end
