Grasshopper.controller "UserCtrl", (['$scope', '$location', '$routeParams','Restangular', 'currentUser', ($scope, $location, $routeParams, Restangular, currentUser) ->
  $scope.currentUser = currentUser

  currentUser.loadData()

  $scope.updateProfile = () ->

    currentUser.data.route = 'users'
    currentUser.data.put().then ( ->
      $location.path('/')
    )

  $scope.params = $routeParams


])