class MessagesController < ApplicationController
  def create
    @message = Message.create!(message_params)
    if params[:message][:images].present?
      @message.images.attach(params[:images])
    end
    flash[:success] = "Your message has been sent!"
    redirect_to @message
  end

  private
    def message_params
      params.require(:message).permit(:title, :content, images: [])
    end
end
