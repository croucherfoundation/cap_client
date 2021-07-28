class RoundType
  include Her::JsonApi::Model
  use_api CAP
  collection_path "/api/round_types"

  class << self

    def preload
      RequestStore.store[:round_types] ||= self.all.fetch
    end

    def find(id)
      preload.find{ |r| r.id && r.id.to_i == id.to_i }
    end

    def for_selection
      preload.sort_by(&:name).map{|rt| [rt.name, rt.id] }
    end

    def with_slug(slugs)
      slugs = [slugs].flatten
      preload.select{ |rt| slugs.include?(rt.slug) }
    end

    def self.new_with_defaults(attributes={})
      RoundType.new({
        name: "",
        code: "",
        populated: false
      }.merge(attributes))
    end
  end

  def populated?
    !!populated
  end

end
