Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', 'Skill', ($scope, $location, $http, User, Skill) ->
  $scope.hasProficiencies = []
  $scope.desiredProficiencies = []

  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result.users[0]
    apprenticeshipsLinks = $scope.currentUser.links.apprenticeships
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

  $scope.editProfile = () ->
    $location.url ('/edit-profile')
]