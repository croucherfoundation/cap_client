class Interviewer
  include Her::JsonApi::Model

  use_api CAP
  collection_path '/api/interviewers'

  belongs_to :round

  class << self
    def by_user_uid(user_uid)
      where(user_uid: user_uid)
    end
  end
end