Grasshopper.controller "ViewProfileCtrl", (['$scope', '$location', '$http', 'User', '$routeParams', ($scope, $location, $http, User, $routeParams) ->

  userId = $routeParams.userId
  $scope.bowLabel = "Bow"

  showOrHideBow = (user, currentUser) ->
    if currentUser.role == "apprentice" and user.role == "master"
      user.showBow = true
      $http.get('/api/apprenticeships').then (result) ->
        existing = _.find(result.data.apprenticeships, (apprenticeship) ->
          apprenticeship.links.master.id == user.id and apprenticeship.links.apprentice.id == currentUser.id
        )
        if existing.status == 'active'
          $scope.bowLabel = "Connected"
          $('#bow-button').removeAttr("data-toggle")
        else if existing.status == 'pending'
          $scope.bowLabel = "Pending"
          $('#bow-button').removeAttr("data-toggle")
        else
          $scope.bowLabel = "Bow"
          $('#bow-button').addAttr("data-toggle")
    else
      user.showBow = false


  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result.users[0]
    console.log 'current user', $scope.currentUser.role
    User.loadOne(userId).then (result) ->
      $scope.user = result.users[0]
      showOrHideBow($scope.user, $scope.currentUser)

  $scope.bowAndMessage = (masterId, apprenticeId) ->
    newApprenticeship = { master_id: masterId, apprentice_id: apprenticeId }
    if $scope.currentUser.role == "apprentice" and $scope.user.role == "master"
      $http.post('/api/apprenticeships', newApprenticeship).success (response) ->
        console.log "Successfully created new apprenticeship"
        $('#bow-modal').modal('hide')
        $scope.bowLabel = "Pending"
        $('#bow-button').removeAttr("data-toggle")
        noty { text: "You've bowed succesfully! Apprenticeship pending.", type: "success" }
      .error (response) ->
        noty { text: "You cannot bow to this user." , type: "error" }

])