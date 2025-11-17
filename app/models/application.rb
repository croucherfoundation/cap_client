class Application
  include Her::JsonApi::Model

  use_api CAP
  collection_path "/api/applications"
  belongs_to :round

  class << self

    def in_round(round_id)
      round_id = round_id.id if round_id.is_a?(Round)
      where(round_id: round_id)
    end

    def submitted_in_round(round_id)
      round_id = round_id.id if round_id.is_a?(Round)
      where(round_id: round_id, submitted: true, unwithdrawn: true)
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

    def admit(id)
      put "api/applications/#{id}/admit"
    end

    def image_award(image_info_id)
      begin
        get "/api/applications/image_award?image_info_id=#{image_info_id}"
      rescue JSON::ParserError
        nil
      end
    end

    def image_awards(options={})
      begin
        get "/api/applications/image_awards?featured=#{options[:featured]}&size=#{options[:size]}&year=#{options[:year]}&image_info_id=#{options[:image_info_id]}"
      rescue JSON::ParserError
        nil
      end
    end
  end

  def self.get_applications(options={})
    get "/api/applications/applicant_lookup?#{options.to_param}"
  rescue JSON::ParserError
    nil
  end

  # These actions are called from Dataroom to manage institution code changes
  #
  def self.update_institution(old_code, new_code)
    post "/api/applications/update_institution?old_code=#{old_code}&new_code=#{new_code}"
  rescue JSON::ParserError
    nil
  end

  def self.check_institution_usage(institution_code)
    get "/api/applications/check_institution_usage?institution_code=#{institution_code}"
  rescue JSON::ParserError
    nil
  end
  # END institution code management actions

  def admit!
    Application.admit(self.id)
  end

  def admitted?
    award_id?
  end

  def submitted?
    submitted_at?
  end

  def serial_and_name
    serial_number = "##{serial}: " if serial?
    [serial_number, name, research_title].map(&:presence).compact.join(' ')
  end
end
