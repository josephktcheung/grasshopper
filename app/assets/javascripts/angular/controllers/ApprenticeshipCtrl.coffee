Grasshopper.controller "ApprenticeshipCtrl", (['$scope', '$location', 'Restangular', 'currentUser', ($scope, $location, Restangular, currentUser) ->
  $scope.currentUser = currentUser

  currentUser.loadData()

  $scope.bow = (apprentice, master) ->
    newApprenticeship = {master_id: master, apprentice_id: apprentice}
    baseApprenticeship.post(newApprenticeship).then ( ->
      $location.path('/')
      )

])
