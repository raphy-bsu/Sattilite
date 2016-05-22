class PublicController < ApplicationController

  def index
  end

  def about
  end

  def contact_us
    @message = Message.new
  end
end
