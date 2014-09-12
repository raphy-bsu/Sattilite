class PublicController < ApplicationController
  def index
    if File.exists? File.join(Rails.root, "out.data")
      @params = Marshal.load(File.read(File.join(Rails.root, "out.data")) )
    else
      @params = {}
    end
  end

  def update
    @params = params.permit(:temp, :hum, :current_year, :current_month, :current_day, :current_time)
    File.open(File.join( Rails.root, "out.data"), "w") { |f| f.write(Marshal.dump(@params)) }
    redirect_to :root
  end
end
