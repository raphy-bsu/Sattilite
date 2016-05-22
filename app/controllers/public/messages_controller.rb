class Public::MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to contact_us_path, notice: 'Message was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:name, :email, :body)
  end
end
