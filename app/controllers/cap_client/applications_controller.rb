module CapClient
  class ApplicationsController < ApplicationController
    respond_to :json
    layout false
    before_filter :get_applications, only: [:index]

    def index
      render json: @applications
    end

    protected

    def get_applications
      @applications = Application.for_selection(params[:round_id])
    end

  end
end