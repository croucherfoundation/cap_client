module CapActiveResourceConfig
  extend ActiveSupport::Concern

  included do
    self.site                   = ENV['APPL_API_URL']
    self.prefix                 = '/api/'
    self.format                 = CapFormatApiResponse
    self.include_format_in_path = false
  end
end
