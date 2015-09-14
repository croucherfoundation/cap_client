class Round
  include Her::JsonApi::Model
  include HasGrant

  use_api CAP
  collection_path "/api/rounds"

  belongs_to :round_type
  has_many :applications

  class << self

    def preload
      @rounds ||= self.all
    end

    def find(id)
      preload.find{ |r| r.id == id }
    end
    
    def find_list(ids)
      preload.select{ |r| ids.include?(r.id) }
    end

    def in_year(year)
      preload.select{ |r| r.year == year }
    end

    def for_selection(year=nil)
      rounds = year ? in_year(year) : preload
      rounds.map{|r| [r.name, r.id] }
    end
    
    def years_for_selection()
      rounds.map(&:year).uniq
    end

    def new_with_defaults(attributes={})
      Round.new({
        year: Date.today.year
      }.merge(attributes))
    end
  end

  def path
    ['rounds',round_type.slug, slug].join('/')
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
