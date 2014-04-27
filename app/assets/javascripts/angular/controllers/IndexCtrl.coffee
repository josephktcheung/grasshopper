Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', ($scope, $location, $http, User) ->

  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result.users[0]

    $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships').then (result) ->
      $scope.connectedUserIds = []
      $scope.activeApprenticeships = []
      $scope.pendingApprenticeships = []
      $scope.inactiveApprenticeships = []

      angular.forEach result.data.apprenticeships, (connection) ->
        if $scope.currentUser.role == 'apprentice'
          $scope.connectedUserIds.push connection.links.master.id
          _.find result.data.linked.users, (user) ->
            if user.id == connection.links.master.id
              if connection.status == 'active'
                $scope.activeApprenticeships.push user
              else if connection.status == 'pending'
                $scope.pendingApprenticeships.push user
              else if connection.status == 'inactive'
                $scope.inactiveApprenticeships.push user
        else if $scope.currentUser.role == 'master'
          $scope.connectedUserIds.push connection.links.apprentice.id
          _.find result.data.linked.users, (user) ->
            if user.id == connection.links.apprentice.id
              if connection.status == 'active'
                $scope.activeApprenticeships.push user
              else if connection.status == 'pending'
                $scope.pendingApprenticeships.push user
              else if connection.status == 'inactive'
                $scope.inactiveApprenticeships.push user

      console.log 'Connect User IDs: ', $scope.connectedUserIds
      console.log 'activeApprenticeships: ', $scope.activeApprenticeships
      console.log 'pendingApprenticeships: ', $scope.pendingApprenticeships
      console.log 'inactiveApprenticeships: ', $scope.inactiveApprenticeships


  $scope.editProfile = () ->
    $location.url '/edit-profile'
]