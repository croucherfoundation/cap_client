class Round
  include Her::JsonApi::Model
  # include HasGrant

  use_api CAP
  collection_path "/api/rounds"

  belongs_to :round_type
  has_many :applications

  class << self

    def preload
      RequestStore.store[:rounds] ||= self.all.fetch
    end

    def find(id)
      preload.find{ |r| r.id && r.id.to_i == id.to_i }
    end

    def find_list(ids)
      preload.select{ |r| r.id && ids.include?(r.id.to_i) }
    end

    def in_year(year)
      preload.select{ |r| r.year == year.to_s }
    end

    def in_year_with_code(year, code)
      preload.select{ |r| r.year == year.to_s && r.grant_type_code == code }
    end

    def of_type(round_type_id)
      round_type_id = round_type_id.id if round_type_id.is_a?(RoundType)
      preload.sort_by(&:year).reverse.select{ |r| r.round_type_id == round_type_id }
    end

    def for_selection(year=nil)
      rounds = year ? in_year(year) : preload
      rounds.sort_by(&:name).reverse.map{|r| [r.name, r.id] }
    end

    def years_for_selection()
      preload.map(&:year).uniq.sort.reverse
    end

    def new_with_defaults(attributes={})
      Round.new({
        year: Date.today.year
      }.merge(attributes))
    end

    def recent
      rounds = []
      ['fss', 'srf', 'cia'].each do |slug|
        if round_type = RoundType.with_slug(slug).first
          if round = Round.of_type(round_type.id.to_i).first
            rounds.push round
          end
        end
      end
      rounds
    end
  end

  def path
    ['rounds', round_type.slug, slug].join('/')
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
