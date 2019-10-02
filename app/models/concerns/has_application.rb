# Consolidating the business of application-having.

module HasApplication
  extend ActiveSupport::Concern

  def application
    Application.find(application_id) if application_id
  end
  
  def application?
    application_id && application
  end

  def application=(application)
    self.application_id = application.id
  end

  def round_id
    application.round_id if application?
  end

  def round
    Round.find(round_id) if round_id
  end

  def round?
    round_id && round
  end
end