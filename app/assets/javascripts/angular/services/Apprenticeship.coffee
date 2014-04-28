Grasshopper.factory('Apprenticeship', ['$http', ($http) ->

  Apprenticeship =

    update: (apprenticeshipId, data) ->
      $http({
        method: "PUT"
        url: "./api/apprenticeships/"+apprenticeshipId
        data: data
      })


])