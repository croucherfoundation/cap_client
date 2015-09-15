class Application
  include Her::JsonApi::Model

  use_api CAP
  collection_path "/api/applications"
  belongs_to :round

  class << self

    def preload
      @applications ||= self.all.fetch
      @applications
    end

    def find(id)
      preload.find{ |a| a.id.to_i == id.to_i }
    end

    def in_round(round_id)
      preload.select{ |a| a.round_id.to_i == round_id.to_i }
    end

    def for_selection(round_id)
      applications = round_id ? in_round(round_id) : preload
      applications.map{|a| [a.serial_and_name, a.id] }
    end
  end
  
  def serial_and_name
    [serial, name, research_title].map(&:presence).compact.join(' ')
  end
  
end
