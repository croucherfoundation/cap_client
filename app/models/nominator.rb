class Nominator
  include Her::JsonApi::Model

  use_api CAP
  collection_path '/api/nominators'

  belongs_to :round

  class << self
    def by_user_uid(user_uid)
      where(user_uid: user_uid)
    end

    def new_with_defaults(attributes={})
      nominator = Nominator.new({
        user_uid: nil,
        institution_code: "",
        user_attributes: {
          title: "", 
          family_name: "", 
          given_name: "", 
          email: "", 
          phone: "",
          defer_confirmation: true
    }

      }.merge(attributes))
      nominator
    end
  end

  def invite
    self.class.get("/api/nominators/#{id}/invite")
  end
end
