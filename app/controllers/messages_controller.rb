class MessagesController < ApplicationController
  respond_to :json

  before_action :get_conversation
  before_action :get_message, only: [ :update, :destroy ]

  def index
    @messages = if params[:id]
      Message.where("id in (?) #{@conversation_clause}", params[:id].split(','))
    else
      @conversation ? @conversation.messages : Message.all
    end
    @users = (@messages.map { |message| [message.sender, message.recipient] }).flatten.sort.uniq
    @conversations = (@messages.map { |message| message.conversation }).sort.uniq
  end

  def create
    message = Message.new message_params

    if message.save
      head :created, location: message_url(message)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @message.update(message_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @message.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def get_conversation
    if params[:conversation_id]
      head :bad_request unless @conversation = Conversation.where("id = ?", params[:conversation_id]).take
    end
    @conversation_clause = @conversation ? "and conversation_id = #{@conversation.id}" : ""
  end

  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :conversation_id, :content)
  end

  def get_message
    head :not_found unless @message = Message.where('id = ?', params[:id]).take
  end
end