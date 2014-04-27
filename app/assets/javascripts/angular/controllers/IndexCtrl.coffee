Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', ($scope, $location, $http, User) ->

  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result.users[0]

    $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships').then (result) ->
      $scope.connectedUserIds = []
      $scope.activeConnections = []
      $scope.pendingConnections = []
      $scope.inactiveConnections = []

      console.log 'Apprenticeship api returns: ', result.data
      angular.forEach result.data.apprenticeships, (connection) ->
        if $scope.currentUser.role == 'apprentice'
          $scope.connectedUserIds.push connection.links.master.id
          _.find result.data.linked.users, (user) ->
            if user.id == connection.links.master.id
              if connection.status == 'active'
                $scope.activeConnections.push "#{user.first_name} #{user.last_name}"
              else if connection.status == 'pending'
                $scope.pendingConnections.push "#{user.first_name} #{user.last_name}"
              else if connection.status == 'inactive'
                $scope.inactiveConnections.push "#{user.first_name} #{user.last_name}"
        else
          $scope.connectedUserIds.push connection.links.apprentice.id
          _.find result.data.linked.users, (user) ->
            if user.id == connection.links.apprentice.id
              if connection.status == 'active'
                $scope.activeConnections.push "#{user.first_name} #{user.last_name}"
              else if connection.status == 'pending'
                $scope.pendingConnections.push "#{user.first_name} #{user.last_name}"
              else if connection.status == 'inactive'
                $scope.inactiveConnections.push "#{user.first_name} #{user.last_name}"

      console.log 'Connect User IDs: ', $scope.connectedUserIds
      console.log 'activeConnections: ', $scope.activeConnections
      console.log 'pendingConnections: ', $scope.pendingConnections
      console.log 'inactiveConnections: ', $scope.inactiveConnections

        # if connection.status == 'pending'
        #   angular.forEach result.data.linked.users, (user) ->
        #     if _.contains $scope.connectedUserIds, user.id
        #       $scope.activeConnections.push "#{user.first_name} #{user.last_name}"
        #     console.log 'Pending Connections: ', $scope.activeConnections

          # _.find result.data.linked.users, (user) ->
          #   user.id == connection.links.master.id
          #   console.log user

        #     $scope.connectedUsers.push connection.
        #     connection.links.master.id
        # result.data.linked.users
        #   console.log user.first_name




    # $http.get('/api/users').then ()

    # $http.get(apprenticeshipsLinks[0].href).then (result) ->
    #   console.log $scope.connectionUsername = result.data.linked.users[1].username
    #   $scope.connectionUserId = result.data.linked.users[1].id
    #   $scope.connectionActive = result.data.apprenticeships[0].is_active

  $scope.editProfile = () ->
    $location.url '/edit-profile'
]