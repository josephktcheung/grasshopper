Grasshopper.controller "SearchCtrl", ['$scope', '$location', 'User', '$http', ($scope, $location, User, $http) ->
  User.loadAll().then (result) ->
    $scope.users = result.users

  User.loadCurrentUser().then (data) ->
    $scope.currentUser = data.users[0]
    filterUsersCommunicatedWith(data)

  filterUsersCommunicatedWith = (data) ->
    existingConversations = []
    angular.forEach data.linked.conversations, (conversation) ->
      existingConversations.push conversation.created_by
      existingConversations.push conversation.created_for
    $scope.usersCommunicatedWith = _.pull(_.uniq(existingConversations), $scope.currentUser.id)

  $scope.search = () ->
    $location.url '/search'

  $scope.searchText = ''

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

  createConversationWith = (user) ->
    conversationParams = {
      conversation:
        created_by_id:  $scope.currentUser.id
        created_for_id: user.id
    }
    $http({
      method: "POST"
      url:    "./api/conversations"
      data:   conversationParams
    })

  createMessageTo = (user, messageText, conversation) ->
    messageParams = {
      message:
        sender_id:  $scope.currentUser.id
        recipient_id: user.id
        content: messageText
        conversation_id: conversation
    }
    $http({
      method: "POST"
      url:    "./api/messages"
      data:   messageParams
    })

  $scope.submitMessage = (user, messageText) ->
    if _.indexOf($scope.usersCommunicatedWith, user.id) == -1 and user.id != $scope.currentUser.id
      console.log 'create new conversation with this user'
      createConversationWith(user).then (response) ->
        conversationId = (/\d+$/.exec response.headers('location'))[0]
        createMessageTo(user, messageText, conversationId).success (response) ->
          console.log 'successfully created conversation and message'
    else
      console.log 'already had conversation with this user before'

]

