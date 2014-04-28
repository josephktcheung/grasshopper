class ConversationsController < ApplicationController
  respond_to :json
  before_action :get_user
  before_action :get_conversation, only: [ :update, :destroy ]

  def index
    @conversations = if params[:id]
      Conversation.where("(id in (?) #{@created_for_clause}) or (id in (?) #{@created_by_clause})", params[:id].split(','), params[:id].split(','))
    else
      @user ? Conversation.involve_user(@user) : Conversation.all
    end
    @users = (@conversations.map { |conversation| [conversation.created_by, conversation.created_for] }).flatten.sort.uniq
    @messages = (@conversations.map { |conversation| conversation.messages }).flatten.sort.uniq
  end

  def create
    conversation = Conversation.new conversation_params

    if conversation.save
      head :created, location: conversation_url(conversation)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @conversation.update(conversation_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @conversation.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def get_user
    if params[:user_id]
      head :bad_request unless @user = User.where("id = ?", params[:user_id]).take
    end
    if @user
      @created_for_user_clause = "and created_for_id = #{@user_id}"
      @created_by_user_clause = "and created_by_id = #{@user_id}"
    else
      ''
    end
  end

  def conversation_params
    safe_params = [
      :created_for_id,
      :created_by_id,
      messages_attributes: [
        :sender_id,
        :recipient_id,
        :content
      ]
    ]
    params.require(:conversation).permit(safe_params)
  end

  def get_conversation
    head :not_found unless @conversation = Conversation.where('id = ?', params[:id]).take
  end
end