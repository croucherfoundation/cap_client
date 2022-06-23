class RoundType < ActiveResource::Base
  include CapFormatApiResponse
  include CapActiveResourceConfig

  class << self

    def preload
      RequestStore.store[:round_types] ||= self.all
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
