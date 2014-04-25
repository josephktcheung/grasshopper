Grasshopper.controller "ViewProfileCtrl", (['$scope', '$location', '$http', 'User', '$routeParams', '$q', ($scope, $location, $http, User, $routeParams, $q) ->

  defer = $q.defer()
  userId = $routeParams.userId
  $scope.bowLabel = "Bow"

  showOrHideBow = (user, currentUser) ->
    console.log 'current', currentUser.id, currentUser.role
    console.log 'user', user.id, user.role
    if currentUser.role == "apprentice" and user.role == "master"
      user.showBow = true
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
        $scope.bowLabel = "Pending Bow"
        $('#bow-button').removeAttr("data-toggle")
    else
      console.log "apprenticeship must be between an apprentice and master"


])
