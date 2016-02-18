class Application
  include Her::JsonApi::Model

  use_api CAP
  collection_path "/api/applications"
  belongs_to :round

  class << self

    def in_round(round_id)
      where(round_id: round_id)
    end

    def for_selection(round_id)
      applications = round_id ? in_round(round_id) : all
      applications.map{|a| [a.serial_and_name, a.id] }
    end
  end

  def serial_and_name
    serial_number = "##{serial}: " if serial?
    [serial_number, name, research_title].map(&:presence).compact.join(' ')
  end

end
