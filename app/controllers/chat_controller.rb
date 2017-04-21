class ChatController < ApplicationController
  before_action :set_article
  def create
    @chat = @article.chat.build(chat_params)
    @chat.user = current_user

    if @chat.save
      flash[:notice] = "Chat has been created"
    else
      flash.now[:alert] = "Chat has not been created"
    end
    redirect_to article_path(@article)
  end

  private
    def chat_params
      params.require(:chat).permit(:body)
    end

end
