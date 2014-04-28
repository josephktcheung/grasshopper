Grasshopper.controller "SearchCtrl", ['$scope', '$location', 'User', '$http', 'Conversation', ($scope, $location, User, $http, Conversation) ->

  reloadUser = () ->
    User.loadCurrentUser().then (data) ->
      $scope.currentUser = data.users[0]
      console.log $scope.conversations = data.linked.conversations
      $scope.usersCommunicatedWith = Conversation.filterUsersCommunicatedWith(data, $scope.currentUser)

  $scope.search = () ->
    $location.url '/search'

  $scope.conversation = () ->
    $location.url '/conversation'

  $scope.viewProfile = () ->
    $location.url '/view-profile'

  $scope.filterByNameOrSkill = (users,searchText) ->
    filteredUsers = []
    searchTextRegExp = RegExp(searchText, 'i')

    angular.forEach users, (user) ->
      if user.first_name.match(searchTextRegExp) or user.last_name.match(searchTextRegExp)
        isMatch = true
      else angular.forEach user.links.proficiencies, (proficiency) ->
        if proficiency.skill.match(searchTextRegExp)
          isMatch = true
      filteredUsers.push user if isMatch == true
    console.log searchText
    filteredUsers

  $("ul.nav.nav-pills.nav-justified li a").click () ->
    $(this).parent().addClass("active").siblings().removeClass "active"
    return

  $scope.submitMessage = (user, messageText) ->
    if _.indexOf($scope.usersCommunicatedWith, user.id) == -1 and user.id != $scope.currentUser.id
      User.createConversationWithMessage($scope.currentUser.id, user.id, messageText).success (response) ->
        $scope.usersCommunicatedWith.push user.id
        reloadUser()
        Conversation.notySuccessForMessage()
      .error (response) ->
        Conversation.notyErrorForMessage()
    else
      conversation = _.find($scope.conversations, (conversation) -> conversation.created_by == user.id || conversation.created_for == user.id)
      User.createMessageTo($scope.currentUser.id, user.id, messageText, conversation.id).success (response) ->
        Conversation.notySuccessForMessage()
      .error (response) ->
        Conversation.notyErrorForMessage()
    $(".modal").modal('hide')
    return

  User.loadAll().then (result) ->
    $scope.users = result.users

  reloadUser()

  $scope.messageText = ''
  $scope.searchText = ''
]

