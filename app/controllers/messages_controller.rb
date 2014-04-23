class MessagesController < ApplicationController

  def index
    @messages = if params[:id]
      Message.where('id in (?)', params[:id].split(','))
    else
      Message.all
    end
  end
end