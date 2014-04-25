Grasshopper.controller "ViewProfileCtrl", (['$scope', '$location', '$http', 'User', '$routeParams', ($scope, $location, $http, User, $routeParams) ->

  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result

  userId = $routeParams.userId

  User.loadOne(userId).then (result) ->
    $scope.user = result.users[0]
])

  $scope.bowAndMessage = (masterId, apprenticeId) ->
    newApprenticeship = { master_id: masterId, apprentice_id: apprenticeId }
    if $scope.currentUser.role == "apprentice" and $scope.user.role == "master"
    $http.post('/api/apprenticeships', newApprenticeship).then ->
      console.log "Successfully created new apprenticeship"

])