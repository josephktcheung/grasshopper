Grasshopper.controller "ViewProfileCtrl", (['$scope', '$location', '$http', 'User', '$routeParams', '$q', ($scope, $location, $http, User, $routeParams, $q) ->

  defer = $q.defer()
  userId = $routeParams.userId
  $scope.bowLabel = "Bow"


  checkExistingApprenticeship = (user, currentUser) ->

    # .then (result) ->
    #   $scope.apprenticeships = result.data.apprenticeships
    #   console.log 'apprenticeships = ', $scope.apprenticeships
    #   console.log 'user = ', user
    #   console.log 'current =', currentUser
    #   existing = _.find($scope.apprenticeships, (apprenticeship) ->
    #     apprenticeship.links.master.id == user.id and apprenticeship.links.apprentice.id == currentUser.id
    #   )
    #   return existing

  showOrHideBow = (user, currentUser) ->
    if currentUser.role == "apprentice" and user.role == "master"
      user.showBow = true
      $http.get('/api/apprenticeships').then (result) ->
        existing = _.find(result.data.apprenticeships, (apprenticeship) ->
          apprenticeship.links.master.id == user.id and apprenticeship.links.apprentice.id == currentUser.id
        )
        if existing
          $scope.bowLabel = "Connected"
          $('#bow-button').removeAttr("data-toggle")
        else
          $scope.bowLabel = "Bow"
          $('#bow-button').addAttr("data-toggle")

    else
      user.showBow = false


  defer.promise
    .then User.loadCurrentUser().then (result) ->
      $scope.currentUser = result
    .then User.loadOne(userId).then (result) ->
      $scope.user = result.users[0]
      showOrHideBow($scope.user, $scope.currentUser)

  defer.resolve()


  $scope.bowAndMessage = (masterId, apprenticeId) ->
    newApprenticeship = { master_id: masterId, apprentice_id: apprenticeId }
    if $scope.currentUser.role == "apprentice" and $scope.user.role == "master"
      $http.post('/api/apprenticeships', newApprenticeship).then ->
        console.log "Successfully created new apprenticeship"
        $('#bow-modal').modal('hide')
        $scope.bowLabel = "Connected"
        $('#bow-button').removeAttr("data-toggle")
    else
      console.log "apprenticeship must be between an apprentice and master"


])

