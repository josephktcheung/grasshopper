Grasshopper.factory('Apprenticeship', ['$http', ($http) ->

  Apprenticeship =

    update: (apprenticeshipId, data) ->
      $http({
        method: "PUT"
        url: "./api/apprenticeships/"+apprenticeshipId
        data: data
      })


    destroy: (apprenticeshipId) ->
      $http({
        method: "DELETE"
        url: "./api/apprenticeships/"+apprenticeshipId
        })

    calculateDuration: (apprenticeship) ->
      if apprenticeship.status == "inactive"
        return end_date - new Date()

])