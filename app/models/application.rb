class Application
  include Her::JsonApi::Model

  use_api CAP
  collection_path "/api/applications"
  belongs_to :round

  class << self

    def in_round(round_id)
      round_id = round_id.id if round_id is_a? Round
      where(round_id: round_id)
    end

    def by_user_uid(user_uid)
      where(user_uid: user_uid)
    end

    def for_selection(round_id)
      applications = round_id ? in_round(round_id) : all
      applications.map{|a| [a.serial_and_name, a.id] }
    end

    def upload_scan(id, file_name)
      begin
        put "api/applications/#{id}/upload_scan/?file_name=#{file_name}"
      rescue JSON::ParserError
        nil
      end
    end

    def delete_scan(id)
      begin
        put "api/applications/#{id}/delete_scan"
      rescue JSON::ParserError
        nil
      end
    end
  
  end

  def serial_and_name
    serial_number = "##{serial}: " if serial?
    [serial_number, name, research_title].map(&:presence).compact.join(' ')
  end
end
