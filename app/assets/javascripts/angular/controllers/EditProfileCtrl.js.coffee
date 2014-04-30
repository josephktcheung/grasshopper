Grasshopper.controller "EditProfileCtrl", (['$scope','$http', '$location', 'User', '$routeParams', '$fileUploader', 'Uploader', 'Skill', ($scope, $http, $location, User, $routeParams, $fileUploader, Uploader, Skill) ->

  notyCreateSkillError = () ->
    noty { text: 'Skill cannot be created! Please try again', type: 'error' }

  notyDeleteSkillError = () ->
    noty { text: 'Skill cannot be deleted! Please try again', type: 'error' }

  loadUserSkills = () ->
    User.loadUserProficiencies($scope.currentUser.id).then (data) ->
      angular.forEach data.proficiencies, (proficiency) ->
        proficiency.text = proficiency.links.skill.name
        if proficiency.proficiency_status == 'has'
          $scope.currentSkills.push proficiency
          $scope.currentSkillsId.push proficiency.links.skill.id
        else
          $scope.desiredSkills.push proficiency
          $scope.desiredSkillsId.push proficiency.links.skill.id

  initialize = () ->
    $scope.currentSkills = []
    $scope.currentSkillsId = []
    $scope.desiredSkills = []
    $scope.desiredSkillsId = []
    $scope.allSkills = []

  loadSkills = (userId) ->
    initialize()
    Skill.loadAll().then (data) ->
      $scope.allSkills = data.skills
      angular.forEach $scope.allSkills, (skill) ->
        skill.text = skill.skill_name
      loadUserSkills()

  $scope.updateProfile = () ->
    User.update($scope.currentUser.id, $scope.currentUser).success (response) ->
      $location.url('/')
      noty {text: 'Successfully updated profile!', type: 'success'}
    .error (response) ->
      noty {text: 'Profile cannot be updated! Please try again', type: 'error'}

  $scope.viewProfile = () ->
    $location.url('/')

  substringMatcher = (strs) ->
    findMatches = (q, cb) ->
      matches = []
      substringRegex = new RegExp(q, 'i')
      $.each strs, (i, str) ->
        if substringRegex.test(str)
          matches.push { value: str }
      cb(matches)

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

  select2ClickableButton = () ->
    $('button[data-select2-open]').on 'click', (e) ->
      $('#' + $(@).data('select2-open')).select2('open')


  createProficiency = (user, skillId, proficiency_status) ->
    data = {
      skill_id: skillId
      proficiency_status: proficiency_status
    }
    $http.post('./api/users/' + user.id + '/proficiencies', data).success (response) ->
      loadSkills($scope.currentUser.id)
    .error (response) ->
      notyCreateSkillError()

  createSkill = (skill_name) ->
    skillData = {
      skill_name: skill_name
    }
    $http.post('./api/skills', skillData)

  removeProficiency = (proficiency) ->
    $http.delete('./api/proficiencies/' + proficiency.id).success (response) ->
      loadSkills($scope.currentUser.id)

  select2ClickableButton()

  User.loadCurrentUser().then (data) ->
    $scope.currentUser = data.users[0]
    $scope.uploader = Uploader.createLoader($scope, User)
    loadSkills($scope.currentUser.id).then ->
      if $scope.currentUser.role == 'master'
        select2CurrentSkills()
      else
        select2CurrentSkills()
        select2DesiredSkills()

  $('#current-skills').on 'change', (e) ->
    if e.added
      skillBeingAdded = _.find $scope.allSkills, (skill) ->
        skill.text == e.added.text
      if skillBeingAdded
        createProficiency($scope.currentUser, skillBeingAdded.id, 'has')
      else
        createSkill(e.added.text).then ->
          newSkillId = response.headers('id')
          createProficiency($scope.currentUser, newSkillId, 'has')
    else
      targetedProficiency = _.find $scope.currentSkills, (skill) ->
        skill.text == e.removed.text
      User.removeProficiency(targetedProficiency).then (response) ->
        loadSkills($scope.currentUser.id)
      .error (response) ->
        notyDeleteSkillError()

  $('#desired-skills').on 'change', (e) ->
    if e.added
      skillBeingAdded = _.find $scope.allSkills, (skill) ->
        skill.text == e.added.text
      if skillBeingAdded
        createProficiency($scope.currentUser, skillBeingAdded.id, 'desired')
      else
        createSkill(e.added.text).then (response) ->
          newSkillId = response.headers('id')
          createProficiency($scope.currentUser, newSkillId, 'desired')
    else
      targetedProficiency = _.find $scope.desiredSkills, (skill) ->
        skill.text == e.removed.text
      removeProficiency(targetedProficiency).error (response) ->
        notyDeleteSkillError()
        loadSkills($scope.currentUser.id)

])










