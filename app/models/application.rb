class Application
  include PaginatedHer::Model

  use_api CAP
  collection_path "/api/applications"
  belongs_to :round

end
