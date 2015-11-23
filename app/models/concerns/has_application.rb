# Consolidating the business of application-having.

module HasApplication
  extend ActiveSupport::Concern

  def application
    Application.find(application_id)
  end
  
  def application?
    application_id && application
  end

  def application=(application)
    self.application_id = application.id
  end

end