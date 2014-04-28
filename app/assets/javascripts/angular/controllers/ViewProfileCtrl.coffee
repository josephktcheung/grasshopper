Grasshopper.controller "ViewProfileCtrl", (['$scope', '$location', '$http', 'User', '$routeParams', ($scope, $location, $http, User, $routeParams) ->

  userId = $routeParams.userId
  $scope.bowLabel = "Bow"

  notySuccessForMessage = () ->
    noty { text: 'Successfully sent a message!', type: 'success' }

  notyErrorForMessage = () ->
    noty { text: 'Message cannot be sent! Please try again', type: 'error' }

  showOrHideBow = (user, currentUser) ->
    if currentUser.role == "apprentice" and user.role == "master"
      user.showBow = true
      $http.get('/api/apprenticeships').then (result) ->
        existing = _.find(result.data.apprenticeships, (apprenticeship) ->
          apprenticeship.links.master.id == user.id and apprenticeship.links.apprentice.id == currentUser.id
        )
        console.log existing
        if existing
          $scope.bowLabel = "Connected"
          # $('#bow-button').removeAttr("data-toggle")
        else
          $scope.bowLabel = "Bow"
          # $('#bow-button').addAttr("data-toggle")

    else
      user.showBow = false



  filterUsersCommunicatedWith = (data) ->
    communicatedUsers = []
    $scope.conversations = data.linked.conversations
    angular.forEach data.linked.conversations, (conversation) ->
      communicatedUsers.push conversation.created_by
      communicatedUsers.push conversation.created_for
    $scope.usersCommunicatedWith = _.pull(communicatedUsers, $scope.currentUser.id)

  $scope.submitMessage = (user, messageText) ->
    if _.indexOf($scope.usersCommunicatedWith, user.id) == -1 and user.id != $scope.currentUser.id
      User.createConversationWithMessage($scope.currentUser, user, messageText).success (response) ->
        $scope.usersCommunicatedWith.push user.id
        reloadUser()
        notySuccessForMessage()
      .error (response) ->
        notyErrorForMessage()
    else
      conversation = _.find($scope.conversations, (conversation) -> conversation.created_by == user.id || conversation.created_for == user.id)
      User.createMessageTo($scope.currentUser, user, messageText, conversation.id).success (response) ->
        notySuccessForMessage()
      .error (response) ->
        notyErrorForMessage()
    $(".modal").modal('hide')
    return

  reloadUser = () ->
    User.loadCurrentUser().then (data) ->
      $scope.currentUser = data.users[0]
      filterUsersCommunicatedWith(data)

  reloadUser().then ->
    User.loadOne(userId).then (result) ->
      $scope.user = result.users[0]
      showOrHideBow($scope.user, $scope.currentUser)

  $scope.bowAndMessage = (masterId, apprenticeId) ->
    newApprenticeship = { master_id: masterId, apprentice_id: apprenticeId }
    if $scope.currentUser.role == "apprentice" and $scope.user.role == "master"
      $http.post('/api/apprenticeships', newApprenticeship).then ->
        console.log "Successfully created new apprenticeship"
        $('#bow-modal').modal('hide')
        $scope.bowLabel = "Connected"
        $('#bow-button').removeAttr("data-toggle")

])

