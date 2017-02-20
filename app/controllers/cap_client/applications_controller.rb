module CapClient
  class ApplicationsController < ApplicationController
    respond_to :json
    layout false

    def index
      @applications = Application.for_selection(params[:round_id])
      render json: @applications
    end

    def search
      @applications = Application.by_user_uid(params[:user_uid])
      render json: @applications
    end

  end
end