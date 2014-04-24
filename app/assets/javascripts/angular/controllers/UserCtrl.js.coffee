Grasshopper.controller "UserCtrl", (['$scope', '$location', 'Restangular', 'targetUser', ($scope, $location, Restangular, targetUser) ->
  $scope.targetUser = targetUser

  targetUser.loadCurrentUser()

  $scope.updateProfile = () ->

    targetUser.data.route = 'users'
    targetUser.data.put().then ( ->
      $location.path('/')
    )

  $scope.params = $routeParams


])