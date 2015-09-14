class Application
  include Her::JsonApi::Model

  use_api CAP
  collection_path "/api/applications"
  belongs_to :round

  class << self

    def preload
      @applications ||= self.all
    end

    def find(id)
      preload.find{ |a| a.id == id }
    end

    def in_round(round_id)
      preload.select{ |a| a.round_id == round_id }
    end

    def for_selection(round_id)
      applications = round ? in_round(round_id) : preload
      applications.map{|a| [a.name, a.id] }
    end

  end
end
