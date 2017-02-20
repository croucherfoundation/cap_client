module CapClient
  class InterviewersController < ApplicationsController
    respond_to :json
    layout false

    def index
      @interviewers = Interviewer.by_user_uid(params[:user_uid])
      render json: @interviewers
    end
  end
end