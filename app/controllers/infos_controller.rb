class InfosController < ApplicationController
  def index
    @data = Info.all.order(created_at: :desc)
  end

  # Non restful, but nobody cares
  def update
    @params = params.permit(:temp, :hum)
    Info.create(@params)
    redirect_to :root
  end
end
