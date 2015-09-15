module CapClient
  class RoundsController < ApplicationController
    respond_to :json
    layout false

    def index
      @rounds = Round.for_selection(params[:year])
      render json: @rounds
    end

  end
end