Grasshopper.controller "ViewProfileCtrl", (['$scope', '$location', '$http', 'User', '$routeParams', 'Skill', ($scope, $location, $http, User, $routeParams, Skill) ->

  userId = $routeParams.userId
  $scope.bowLabel = "Bow"
  $scope.allApprenticeships = []

  currentdate = new Date()

  notySuccessForMessage = () ->
    noty { text: 'Successfully sent a message!', type: 'success' }

  notyErrorForMessage = () ->
    noty { text: 'Message cannot be sent! Please try again', type: 'error' }

  showOrHideBow = (user, currentUser) ->
    if currentUser.role == "apprentice" and user.role == "master"
      user.showBow = true
      $http.get('/api/users/'+currentUser.id+'/apprenticeships').then (result) ->
        existing = _.find result.data.apprenticeships, (apprenticeship) ->
          apprenticeship.links.master.id == user.id and apprenticeship.status == 'active'
        existingPending = _.find result.data.apprenticeships, (apprenticeship) ->
          apprenticeship.links.master.id == user.id and apprenticeship.status == 'pending'
        if existing or existingPending
          $scope.user.disableBow = true
        else
          $scope.user.disableBow = false
    else
      user.showBow = false

  filterUsersCommunicatedWith = (data) ->
    communicatedUsers = []
    $scope.conversations = data.linked.conversations
    angular.forEach data.linked.conversations, (conversation) ->
      communicatedUsers.push conversation.created_by
      communicatedUsers.push conversation.created_for
    $scope.usersCommunicatedWith = _.pull(communicatedUsers, $scope.currentUser.id)

  $scope.submitMessage = (user, messageText) ->
    if _.indexOf($scope.usersCommunicatedWith, user.id) == -1 and user.id != $scope.currentUser.id
      User.createConversationWithMessage($scope.currentUser, user, messageText).success (response) ->
        $scope.usersCommunicatedWith.push user.id
        reloadUser()
        notySuccessForMessage()
      .error (response) ->
        notyErrorForMessage()
    else
      conversation = _.find($scope.conversations, (conversation) -> conversation.created_by == user.id || conversation.created_for == user.id)
      console.log 'currentUser: ', $scope.currentUser
      console.log 'user: ', $scope.user
      User.createMessageTo($scope.currentUser, user, messageText, conversation.id).success (response) ->
        notySuccessForMessage()
      .error (response) ->
        notyErrorForMessage()
    $(".modal").modal('hide')
    return

  reloadUser = () ->
    User.loadCurrentUser().then (data) ->
      $scope.currentUser = data.users[0]
      filterUsersCommunicatedWith(data)


  initialize = () ->
    $scope.currentSkillsId = []
    $scope.desiredSkillsId = []

  loadUserSkills = () ->
    User.loadUserProficiencies($scope.user.id).then (data) ->
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
      tags: $scope.allSkills
      dropdownAutoWidth: true
    })

  select2DesiredSkills = () ->
    $('#desired-skills').val($scope.desiredSkillsId).select2({
      tags: $scope.allSkills
      dropdownAutoWidth: true
    })

  reloadUser().then ->
    User.loadOne(userId).then (result) ->
      $scope.user = result.users[0]
      showOrHideBow($scope.user, $scope.currentUser)
      loadSkills($scope.user.id).then ->
      if $scope.user.role == 'master'
        select2CurrentSkills()
        $('#current-skills').select2('enable', false)
      else
        select2CurrentSkills()
        select2DesiredSkills()
        $('#current-skills').select2('enable', false)
        $('#desired-skills').select2('enable', false)

      $http.get('/api/users/'+$scope.user.id+'/apprenticeships').then (result) ->
        angular.forEach result.data.apprenticeships, (apprenticeship) ->
          if apprenticeship.status != 'pending'
            $scope.allApprenticeships.push apprenticeship
        console.log 'allApprenticeships', $scope.allApprenticeships

  $scope.getDuration = (apprenticeship) ->
    apprenticeship.end_date - currentdate

  $scope.bowAndMessage = (masterId, apprenticeId, messageText) ->
    newApprenticeship = { master_id: masterId, apprentice_id: apprenticeId }
    if $scope.currentUser.role == "apprentice" and $scope.user.role == "master"
      $http.post('/api/apprenticeships', newApprenticeship).success (response) ->
        $('#bow-modal').modal('hide')
        $scope.user.disableBow = true
        noty { text: "You've bowed succesfully! Apprenticeship pending.", type: "success" }
      .error (response) ->
        noty { text: "You cannot bow to this user." , type: "error" }
      $scope.submitMessage($scope.user, messageText)

])
