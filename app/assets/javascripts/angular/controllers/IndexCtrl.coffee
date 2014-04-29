Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', 'Apprenticeship', 'Skill', ($scope, $location, $http, User, Apprenticeship, Skill) ->

  User.loadCurrentUser().then (result) ->
    $scope.allApprenticeships = []
    $scope.currentUser = result.users[0]
    $http.get('/api/users/'+$scope.currentUser.id+'/apprenticeships').then (result) ->
      angular.forEach result.data.apprenticeships, (apprenticeship) ->
        $scope.allApprenticeships.push apprenticeship
    loadSkills($scope.currentUser.id).then ->
      if $scope.currentUser.role == 'master'
        select2CurrentSkills()
      else
        select2CurrentSkills()
        select2DesiredSkills()
      $('#current-skills').select2('enable', false)
      $('#desired-skills').select2('enable', false)

  initialize = () ->
    $scope.currentSkillsId = []
    $scope.desiredSkillsId = []

  loadUserSkills = () ->
    User.loadUserProficiencies($scope.currentUser.id).then (data) ->
      angular.forEach data.proficiencies, (proficiency) ->
        proficiency.text = proficiency.links.skill.name
        if proficiency.proficiency_status == 'has'
          $scope.currentSkillsId.push proficiency.links.skill.id
        else
          $scope.desiredSkillsId.push proficiency.links.skill.id

  loadSkills = (userId) ->
    initialize()
    Skill.loadAll().then (data) ->
      $scope.allSkills = data.skills
      angular.forEach $scope.allSkills, (skill) ->
        skill.text = skill.skill_name
      loadUserSkills()

  select2CurrentSkills = () ->
    $('#current-skills').val($scope.currentSkillsId).select2({
      placeholder: "Add your current skills here"
      tags: $scope.allSkills
      dropdownAutoWidth: true
    })

  select2DesiredSkills = () ->
    $('#desired-skills').val($scope.desiredSkillsId).select2({
      placeholder: "Add desired skills here"
      tags: $scope.allSkills
      dropdownAutoWidth: true
    })

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
    $location.url ('/edit-profile')

  $scope.hasProficiencies = []
  $scope.desiredProficiencies = []

]