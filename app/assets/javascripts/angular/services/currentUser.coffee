Grasshopper.factory('currentUser', ['Restangular', (Restangular) ->

  currentUser =
    data:
      role: ""
      username: ""
      first_name: ""
      last_name: ""
      is_active: ""
      activeorinactive: ""

  checkActive = () ->
    if currentUser.data.is_active
      currentUser.data.activeorinactive = "Active"
      currentUser.data.activeLabel = "label-success"
    else
      currentUser.data.activeorinactive = "Inactive"
      currentUser.data.activeLabel = "label-danger"

  currentUser.loadData = () ->
    Restangular.all('user').getList().then (user) ->
      console.log currentUser.data = user[0]
      checkActive()

  return currentUser

])