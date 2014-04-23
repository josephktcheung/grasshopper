Grasshopper.controller "IndexCtrl", ['$scope', '$location', 'Restangular', 'currentUser', ($scope, $location, Restangular, currentUser) ->

  initialize = () ->
    baseUsers = Restangular.all('users')
    baseUsers.getList().then (users) ->
      $scope.users = users

  $scope.currentUser = currentUser

  currentUser.loadData()

  initialize()

  $scope.editProfile = () ->
    $location.url '/edit-profile'


]