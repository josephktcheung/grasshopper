Grasshopper.controller "UsersController", ['$scope', 'Restangular', ($scope, Restangular) ->
  $scope.initialize = () ->
    baseUsers = Restangular.all('users')

    conversations = Restangular.all('conversations')

    baseUsers.getList().then (users) ->
      $scope.users = users

    # Restangular.one('users', 1).all('proficiencies').getList();
    # $scope.user.all('proficiencies').getList();

]

