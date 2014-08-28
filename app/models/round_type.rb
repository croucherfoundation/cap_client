class RoundType
  include PaginatedHer::Model

  use_api CAP
  collection_path "/api/round_types"

end
