Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', ($scope, $location, $http, User) ->

  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result.users[0]
    console.log $scope.currentUser

    $http.get('/api/users/'+$scope.currentUser.id).then (result) ->
      $scope.connections = []
      angular.forEach result.data.apprenticeships, (connection) ->
        if $scope.currentUser.role == 'apprentice'
          if connection.links.apprentice.id == $scope.currentUser.id
            $scope.connections.push connection.links.master.id
        else
          $scope.connections.push connection.links.apprentice.id
      console.log $scope.connections

      # angular.forEach $scope.connections,




    # $http.get('/api/users').then ()

    # $http.get(apprenticeshipsLinks[0].href).then (result) ->
    #   console.log $scope.connectionUsername = result.data.linked.users[1].username
    #   $scope.connectionUserId = result.data.linked.users[1].id
    #   $scope.connectionActive = result.data.apprenticeships[0].is_active

  $scope.editProfile = () ->
    $location.url '/edit-profile'
]