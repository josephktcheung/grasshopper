Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', ($scope, $location, $http, User) ->

  User.loadCurrentUser().then (result) ->
    $scope.allApprenticeships = []
    $scope.currentUser = result.users[0]

    $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships').then (result) ->
      console.log 'result: ', result.data.apprenticeships
      angular.forEach result.data.apprenticeships, (apprenticeship) ->
        $scope.allApprenticeships.push apprenticeship

    console.log '$scope.allApprenticeships', $scope.allApprenticeships


  $scope.updateApprenticeship = (apprenticeship) ->

    console.log 'apprenticeship in updateApprenticeship: ', apprenticeship
    apprenticeshipParams = {
      status: "active"
    }

    $http({
      method: "PUT"
      url: "./api/apprenticeships/"+apprenticeship.id
      data: apprenticeshipParams
    }).success (response) ->
      $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships/'+apprenticeship.id).then (result) ->
        console.log 'apprenticeship result after success: ', result.data
        updated = result.data.apprenticeships[0]
        index = $scope.allApprenticeships.indexOf(apprenticeship)
        if index != -1
          $scope.allApprenticeships[index] = updated
    .error (response) ->
      noty {text: 'Apprenticeship cannot be updated! Please try again', type: 'error'}

  $scope.showBowButtons = (apprenticeship) ->
    if apprenticeship.status == "pending" and $scope.currentUser.role == "master"
      true
    else
      false

  $scope.editProfile = () ->
    $location.url '/edit-profile'
]