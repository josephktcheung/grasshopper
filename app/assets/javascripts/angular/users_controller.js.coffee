Grasshopper.controller "UsersController", ['$scope', 'Restangular', ($scope, Restangular) ->
  $scope.initialize = () ->
    baseUsers = Restangular.all('users')

    conversations = Restangular.all('conversations')

    baseUsers.getList().then (users) ->
      $scope.users = users

]