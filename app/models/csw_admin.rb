class CswAdmin
  include Her::JsonApi::Model

  use_api CAP
  collection_path '/api/csw_admins'

  class << self
    def new_with_defaults
      CswAdmin.new({
        user_uid: nil,
        csw_partner_id: "",
        user_attributes: {
          title: "", 
          family_name: "", 
          given_name: "", 
          email: "", 
          phone: "",
          defer_confirmation: true
    }
      })
    end
  end

  def invite
    self.class.get("/api/csw_admins/#{id}/invite")
  end
end
