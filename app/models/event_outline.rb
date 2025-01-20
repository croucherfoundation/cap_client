class EventOutline
  include Her::JsonApi::Model

  use_api CAP
  collection_path '/api/event_outlines'

  belongs_to :round

  class << self
    def by_contract_id(contract_id)
      where(contract_id: contract_id)
    end
  end
end
