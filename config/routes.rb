CapClient::Engine.routes.draw do 

  get "/rounds" => "rounds#index", :as => 'rounds', :defaults => {:format => :json}
  get "/rounds/:year" => "rounds#index", :as => 'rounds_in_year', :defaults => {:format => :json}
  get "/applications/:round_id" => "applications#index", :as => 'applications', :defaults => {:format => :json}

end
