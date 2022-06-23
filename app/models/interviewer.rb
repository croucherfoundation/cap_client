class Interviewer < ActiveResource::Base
  include CapFormatApiResponse
  include CapActiveResourceConfig

  belongs_to :round

  class << self
    def by_user_uid(user_uid)
      where(user_uid: user_uid)
    end
  end
end
