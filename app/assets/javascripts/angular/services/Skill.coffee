Grasshopper.factory 'Skill', ['$http', ($http) ->
  Skill =
    loadAll: () ->
      $http.get('./api/skills').then (result) ->
        result.data
]