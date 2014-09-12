class PublicController < ApplicationController
  def index
    @params = params.permit(:temp, :hum, :current_year, :current_month, :current_day, :current_time)
  end
end
