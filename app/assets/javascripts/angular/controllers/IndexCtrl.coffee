Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', ($scope, $location, $http, User) ->

  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result.users[0]
    apprenticeshipsLinks = $scope.currentUser.links.apprenticeships
    $http.get(apprenticeshipsLinks[0].href).then (result) ->
      console.log $scope.connectionUsername = result.data.linked.users[1].username
      $scope.connectionUserId = result.data.linked.users[1].id
      $scope.connectionActive = result.data.apprenticeships[0].is_active

  $scope.editProfile = () ->
    $location.url '/edit-profile'
]