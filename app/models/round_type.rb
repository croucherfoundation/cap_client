class RoundType
  include Her::JsonApi::Model
  use_api CAP
  collection_path "/api/round_types"

  def self.new_with_defaults(attributes={})
    RoundType.new({
      name: "",
      code: ""
    }.merge(attributes))
  end

  def self.for_selection
    RoundType.all.sort_by(&:name).map{|rt| [rt.name, rt.id] }
  end

end
