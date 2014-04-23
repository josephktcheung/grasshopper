class ConversationsController < ApplicationController

  def index
    @conversations = if params[:id]
      Conversation.where('id in (?)', params[:id].split(','))
    else
      Conversation.all
    end
  end
end