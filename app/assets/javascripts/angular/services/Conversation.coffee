Grasshopper.factory 'Conversation', ['$http', ($http) ->
  Conversation =
    notySuccessForMessage: () ->
      noty { text: 'Successfully sent a message!', type: 'success' }

    notyErrorForMessage: () ->
      noty { text: 'Message cannot be sent! Please try again', type: 'error' }

    filterUsersCommunicatedWith: (data, currentUser) ->
      users = []
      angular.forEach data.linked.conversations, (conversation) ->
        users.push conversation.created_by
        users.push conversation.created_for
      usersCommunicatedWith = _.pull(users, currentUser.id)

  Conversation
]