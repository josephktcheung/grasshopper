Grasshopper.factory 'User', ['$http', ($http) ->

  User =
    checkActive: (result) ->
      if result.data.users[0].is_active
        result.data.users[0].activeorinactive = "Active"
        result.data.users[0].activeLabel = "label-success"
      else
        result.data.users[0].activeorinactive = "Inactive"
        result.data.users[0].activeLabel = "label-danger"

    loadOne: (userId) ->
      $http.get('./api/users/'+userId).then (result) ->
        User.checkActive(result)
        result.data

    loadAll: () ->
      $http.get('./api/users').then (result) ->
        result.data

    loadCurrentUser: () ->
      $http.get('./api/user').then (result) ->
        User.checkActive(result)
        result.data

    update: (userId, data) ->
      $http({
        method: "PUT"
        url: "./api/users/"+userId
        data: data
      })

    removeProficiency: (proficiencyUrl) ->
      $http.delete(proficiencyUrl)

    createConversationWithMessage: (created_by, created_for, messageText) ->
      conversationParams = {
        created_by_id:  created_by.id
        created_for_id: created_for.id
        messages_attributes: [
          sender_id: created_by.id
          recipient_id: created_for.id
          content: messageText
        ]
      }
      $http({
        method: "POST"
        url:    "./api/conversations"
        data:   conversationParams
      })

    createMessageTo: (sender, recipient, messageText, conversationId) ->
      messageParams = {
        sender_id:  sender.id
        recipient_id: recipient.id
        content: messageText
        conversation_id: conversationId
      }
      $http({
        method: "POST"
        url:    "./api/messages"
        data:   messageParams
      })

  User

]