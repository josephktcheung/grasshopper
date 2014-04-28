Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', ($scope, $location, $http, User) ->

  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result.users[0]

    $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships').then (result) ->


  $scope.editProfile = () ->
    $location.url '/edit-profile'
]