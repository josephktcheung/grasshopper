Grasshopper.controller "EditProfileCtrl", (['$scope','$http', '$location', 'User', '$routeParams', '$fileUploader', 'Uploader', ($scope, $http, $location, User, $routeParams, $fileUploader, Uploader) ->

  User.loadCurrentUser().then (data) ->
    $scope.currentUser = data.users[0]
    console.log 'uploader: ', $scope.uploader = Uploader.createLoader($scope, User)

  $scope.updateProfile = () ->
    User.update($scope.currentUser.id, $scope.currentUser).success (response) ->
      $location.url('/')
      noty {text: 'Successfully updated profile!', type: 'success'}
    .error (response) ->
      noty {text: 'Profile cannot be updated! Please try again', type: 'error'}

  $scope.viewProfile = () ->
    $location.url('/')

  $scope.removeProficiency = (proficiencyUrl) ->
    User.removeProficiency(proficiencyUrl)
    idx = _.findIndex $scope.currentUser.links.proficiencies, (proficiency) ->
      proficiency.href == proficiencyUrl
    $scope.currentUser.links.proficiencies.splice idx, 1



])