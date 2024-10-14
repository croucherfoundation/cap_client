class Grantor
  include Her::JsonApi::Model

  use_api CAP
  collection_path '/api/grantors'

  belongs_to :round

  class << self
    def by_user_uid(user_uid)
      where(user_uid: user_uid)
    end
  end
end
