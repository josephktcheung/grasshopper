Grasshopper.controller "ConversationCtrl", ['$scope', '$location', 'User', 'Conversation', '$http', '$anchorScroll', ($scope, $location, User, Conversation, $http, $anchorScroll) ->
  reloadUser = () ->
    User.loadCurrentUser().then (data) ->
      $scope.currentUser = data.users[0]
      loadConvo()

  targetUser = (forOrBy, conversation) ->
    conversation.targetUserId = conversation.links[forOrBy].id
    conversation.targetUserAvatar = conversation.links[forOrBy].avatar_url
    conversation.targetUserFirstName = conversation.links[forOrBy].first_name
    conversation.targetUserLastName = conversation.links[forOrBy].last_name

  loadConvo = () ->
    User.loadUserConversations($scope.currentUser.id).then (data) ->
      $scope.conversations = data.conversations
      angular.forEach $scope.conversations, (conversation) ->
        if conversation.links.created_by.id != $scope.currentUser.id
          targetUser('created_by', conversation)
        else
          targetUser('created_for', conversation)
        if conversation.links.messages.length > 0
          conversation.lastMsg = _.find conversation.links.messages, (message) ->
            conversation.targetUserId == message.sender
      $scope.usersCommunicatedWith = Conversation.filterUsersCommunicatedWith(data, $scope.currentUser)

  reloadMessages = (conversation) ->
    $scope.selectedConvo = conversation
    console.log 'conversation: ', conversation
    $http.get('./api/conversations/'+conversation.id+'/messages').then (response) ->
      console.log 'response: ', response
      $scope.messages = response.data.messages
      console.log 'msg: ', $scope.messages
      $('#message-box').scrollTop($('#message-box')[0].scrollHeight)


  $scope.loadMessages = (conversation) ->
    reloadMessages(conversation)

  $scope.search = () ->
    $location.url '/search'

  $scope.conversation = () ->
    $location.url '/conversation'

  $scope.viewProfile = () ->
    $location.url '/view-profile'

  $scope.submitMessage = (conversation, messageText) ->
    User.loadOne($scope.selectedConvo.targetUserId).then (data) ->
      User.createMessageTo($scope.currentUser, data.users[0] , messageText, $scope.selectedConvo.id).success (response) ->
        $scope.messageText = ''
        loadConvo()
        reloadMessages(conversation)
      .error (response) ->
        Conversation.notyErrorForMessage()
      return

  reloadUser()

]