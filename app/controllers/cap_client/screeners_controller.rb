module CapClient
  class ScreenersController < ApplicationController
    respond_to :json
    layout false

    def index
      @screeners = Screener.by_user_uid(params[:user_uid])
      render json: @screeners
    end
  end
end
