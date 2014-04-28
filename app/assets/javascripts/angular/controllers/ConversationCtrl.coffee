Grasshopper.controller "ConversationCtrl", ['$scope', '$location', 'User', 'Conversation', '$http', ($scope, $location, User, Conversation, $http) ->
  reloadUser = () ->
    User.loadCurrentUser().then (data) ->
      $scope.currentUser = data.users[0]
      loadConvo()

  loadConvo = () ->
    User.loadUserConversations($scope.currentUser.id).then (data) ->
      $scope.conversations = data.conversations
      console.log 'load convo: ', data
      angular.forEach $scope.conversations, (conversation) ->
        if conversation.links.created_by.id != $scope.currentUser.id
          conversation.targetUserId = conversation.links.created_by.id
          conversation.targetUserAvatar = conversation.links.created_by.avatar_url
          conversation.targetUserFirstName = conversation.links.created_by.first_name
          conversation.targetUserLastName = conversation.links.created_by.last_name
        else
          conversation.targetUserId = conversation.links.created_for.id
          conversation.targetUserAvatar = conversation.links.created_for.avatar_url
          conversation.targetUserFirstName = conversation.links.created_for.first_name
          conversation.targetUserLastName = conversation.links.created_for.last_name
        if conversation.links.messages.length > 0
          conversation.lastMsg = _.last(conversation.links.messages).content
      $scope.usersCommunicatedWith = Conversation.filterUsersCommunicatedWith(data, $scope.currentUser)

  $scope.loadMessages = (conversation) ->
    $scope.messages = []
    $scope.selectedConvo = conversation
    $http.get('./api/conversations/'+conversation.id+'/messages').then (response) ->
      console.log 'msg:', $scope.messages = response.data.messages


  $scope.search = () ->
    $location.url '/search'

  $scope.conversation = () ->
    $location.url '/conversation'

  $scope.viewProfile = () ->
    $location.url '/view-profile'

  $scope.submitMessage = (conversation, messageText) ->
    User.createMessageTo($scope.currentUser.id, $scope.selectedConvo.targetUserId, messageText, $scope.selectedConvo.id).success (response) ->
      Conversation.notySuccessForMessage()
      $scope.messageText = ''
      loadConvo()
    .error (response) ->
      Conversation.notyErrorForMessage()
    return

  reloadUser()

]