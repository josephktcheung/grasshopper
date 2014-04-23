Grasshopper.controller "UserCtrl", (['$scope', '$location', 'Restangular', 'currentUser', ($scope, $location, Restangular, currentUser) ->
  $scope.currentUser = currentUser

  currentUser.loadData()

  $scope.updateProfile = () ->

    currentUser.data.route = 'users'
    currentUser.data.put().then ( ->
      $location.path('/')
    )
])