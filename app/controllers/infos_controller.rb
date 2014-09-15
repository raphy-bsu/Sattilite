class InfosController < ApplicationController
  def index
    @data = Info.all
    @ordered = @data.order(created_at: :desc)
    @labels = @data.pluck(:created_at).map{|l| l.strftime("%T") }
    @temps = @data.pluck(:temp)
    @hums = @data.pluck(:hum)
    respond_to do |format|
      format.html
      format.json
    end
  end

  # Non restful, but nobody cares
  def update
    @params = params.permit(:temp, :hum)
    Info.create(@params)
    redirect_to :root
  end

  def clean
    Info.destroy_all
    redirect_to :root
  end
end
