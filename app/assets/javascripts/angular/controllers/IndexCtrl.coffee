Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', 'Apprenticeship', ($scope, $location, $http, User, Apprenticeship) ->

  User.loadCurrentUser().then (result) ->
    $scope.allApprenticeships = []
    $scope.currentUser = result.users[0]

    $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships').then (result) ->
      angular.forEach result.data.apprenticeships, (apprenticeship) ->
        $scope.allApprenticeships.push apprenticeship

  $scope.acceptApprenticeship = (apprenticeship, newStatus) ->
    apprenticeshipParams = {
      status: newStatus
    }
    console.log 'apprenticeshipParams', apprenticeshipParams
    Apprenticeship.update(apprenticeship.id, apprenticeshipParams).success (response) ->
      $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships/'+apprenticeship.id).then (result) ->
        updated = result.data.apprenticeships[0]
        index = $scope.allApprenticeships.indexOf(apprenticeship)
        if index != -1
          $scope.allApprenticeships[index] = updated
    .error (response) ->
      noty {text: 'Apprenticeship cannot be updated! Please try again', type: 'error'}

  $scope.endApprenticeship = (apprenticeship, newStatus) ->
    apprenticeshipParams = {
      status: newStatus
      end_date: new Date()
    }
    console.log "apprenticeshipParams: ", apprenticeshipParams
    Apprenticeship.update(apprenticeship.id, apprenticeshipParams).success (response) ->
      $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships/'+apprenticeship.id).then (result) ->
        updated = result.data.apprenticeships[0]
        index = $scope.allApprenticeships.indexOf(apprenticeship)
        if index != -1
          $scope.allApprenticeships[index] = updated
    .error (response) ->
      noty {text: 'Apprenticeship cannot be updated! Please try again', type: 'error'}

  $scope.declineApprenticeship = (apprenticeship) ->
    Apprenticeship.destroy(apprenticeship.id).success (response) ->
      $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships').then (result) ->
      angular.forEach result.data.apprenticeships, (apprenticeship) ->
        $scope.allApprenticeships.push apprenticeship
    .error (response) ->
      noty {text: 'Apprenticeship cannot be ended! Please try again', type: 'error'}

  $scope.showBowButtons = (apprenticeship) ->
    if apprenticeship.status == "pending" and $scope.currentUser.role == "master"
      true
    else
      false

  $scope.showEndApprenticeship = (apprenticeship) ->
    if apprenticeship.status == "active"
      true
    else
      false

  $scope.editProfile = () ->
    $location.url '/edit-profile'
]