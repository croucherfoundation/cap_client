class Round
  include PaginatedHer::Model
  include HasGrant

  use_api CAP
  collection_path "/api/rounds"

  belongs_to :round_type
  # has_many :applications

  def self.new_with_defaults(attributes={})
    Round.new({
      
    }.merge(attributes))
  end
  
  def self.for_selection(round_type=nil)
    
  end

  def path
    parts = ['rounds']
    parts.push(round_type.slug) if round_type
    parts.push(slug)
    parts.join('/')
  end
  
  def selection_path
    path + '/selection'
  end
  
  def open?
    applications_end && (closing_date > Time.now) && (!opening_date || opening_date < Time.now)
  end

  def opening_date
    Date.parse(start) if start?
  end

  def opening_datetime
    DateTime.parse(start) if start?
  end
  
  def closing_date
    Date.parse(applications_end) if applications_end?
  end

  def closing_datetime
    DateTime.parse(applications_end) if applications_end?
  end

end
