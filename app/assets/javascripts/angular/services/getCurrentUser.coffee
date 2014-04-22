Grasshopper.factory('getCurrentUser', ['Restangular', (Restangular) ->

  getCurrentUser =
    currentUser:
      data:
        role: ""
        first_name: ""
        last_name: ""
        is_active: ""
        activeorinactive: ""

  checkActive = () ->
    if getCurrentUser.currentUser.data.is_active
      getCurrentUser.currentUser.data.activeorinactive = "Active"
      getCurrentUser.currentUser.data.activeLabel = "label-success"
    else
      getCurrentUser.currentUser.data.activeorinactive = "Inactive"
      getCurrentUser.currentUser.data.activeLabel = "label-danger"

  getCurrentUser.loadData = () ->
    Restangular.all('user').getList().then (user) ->
      getCurrentUser.currentUser.data = user[0]
      checkActive()

  return getCurrentUser

])